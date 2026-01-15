-- ============================================================================
-- Tammo: Household (Care Team) Feature - Supabase Setup
-- ============================================================================
-- Dieses SQL-Skript erstellt die notwendigen Tabellen und RLS-Policies
-- für das gemeinsame Haushaltsverwaltungs-Feature in Supabase.
--
-- Führe dieses Skript im Supabase SQL Editor aus.
-- ============================================================================

-- ============================================================================
-- 1. TABELLEN ERSTELLEN
-- ============================================================================

-- Households: Die Einheit, in der Personen zusammenarbeiten
CREATE TABLE IF NOT EXISTS households (
  household_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  created_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Household Members: Mitglieder eines Haushalts
CREATE TABLE IF NOT EXISTS household_members (
  member_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id UUID NOT NULL REFERENCES households(household_id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT,
  display_name TEXT,
  role TEXT NOT NULL CHECK (role IN ('owner', 'admin', 'caregiver')),
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('pending', 'active', 'removed')),
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(household_id, user_id)
);

-- Household Invitations: Einladungen zu einem Haushalt
CREATE TABLE IF NOT EXISTS household_invitations (
  invite_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id UUID NOT NULL REFERENCES households(household_id) ON DELETE CASCADE,
  invite_token TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'caregiver' CHECK (role IN ('admin', 'caregiver')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'revoked', 'expired')),
  message TEXT,
  created_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- ============================================================================
-- 2. INDIZES FÜR PERFORMANCE
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_household_members_household_id ON household_members(household_id);
CREATE INDEX IF NOT EXISTS idx_household_members_user_id ON household_members(user_id);
CREATE INDEX IF NOT EXISTS idx_household_invitations_token ON household_invitations(invite_token);
CREATE INDEX IF NOT EXISTS idx_household_invitations_email ON household_invitations(email);
CREATE INDEX IF NOT EXISTS idx_household_invitations_household_id ON household_invitations(household_id);

-- ============================================================================
-- 3. ROW LEVEL SECURITY (RLS) AKTIVIEREN
-- ============================================================================

ALTER TABLE households ENABLE ROW LEVEL SECURITY;
ALTER TABLE household_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE household_invitations ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- 3.1 HILFSFUNKTIONEN (MÜSSEN VOR POLICIES DEFINIERT WERDEN)
-- ============================================================================

-- Funktion zum Prüfen der Haushaltsmitgliedschaft
CREATE OR REPLACE FUNCTION is_household_member(p_household_id UUID)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER -- Wichtig: Läuft mit Rechten des Erstellers, um Rekursion zu vermeiden
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM household_members
    WHERE household_id = p_household_id
    AND user_id = auth.uid()
    AND status = 'active'
  );
END;
$$;

-- Funktion zum Abrufen der Rolle eines Nutzers in einem Haushalt
CREATE OR REPLACE FUNCTION get_household_role(p_household_id UUID)
RETURNS TEXT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_role TEXT;
BEGIN
  SELECT role INTO v_role
  FROM household_members
  WHERE household_id = p_household_id
  AND user_id = auth.uid()
  AND status = 'active';
  
  RETURN v_role;
END;
$$;

-- Funktion zum Prüfen ob Nutzer Owner oder Admin ist
CREATE OR REPLACE FUNCTION can_manage_household(p_household_id UUID)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM household_members
    WHERE household_id = p_household_id
    AND user_id = auth.uid()
    AND status = 'active'
    AND role IN ('owner', 'admin')
  );
END;
$$;

-- Funktion zum sicheren Abrufen der E-Mail des aktuellen Nutzers (vermeidet direkten Zugriff auf auth.users in Policies)
CREATE OR REPLACE FUNCTION get_my_email()
RETURNS TEXT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN (SELECT email FROM auth.users WHERE id = auth.uid());
END;
$$;

-- ============================================================================
-- 4. RLS POLICIES FÜR HOUSEHOLDS
-- ============================================================================

-- Nutzer können nur Haushalte sehen, in denen sie Mitglied sind
CREATE POLICY "Users can view their households"
ON households FOR SELECT
TO authenticated
USING (
  (SELECT is_household_member(household_id))
);

-- Nur authentifizierte Nutzer können Haushalte erstellen
CREATE POLICY "Users can create households"
ON households FOR INSERT
TO authenticated
WITH CHECK ((SELECT auth.uid()) = created_by);

-- Nur Owner/Admin können Haushalte aktualisieren
CREATE POLICY "Owners and admins can update households"
ON households FOR UPDATE
TO authenticated
USING (
  (SELECT can_manage_household(household_id))
);

-- Nur Owner können Haushalte löschen
CREATE POLICY "Only owners can delete households"
ON households FOR DELETE
TO authenticated
USING (
  (SELECT get_household_role(household_id)) = 'owner'
);

-- ============================================================================
-- 5. RLS POLICIES FÜR HOUSEHOLD_MEMBERS
-- ============================================================================

-- Mitglieder können andere Mitglieder ihres Haushalts sehen
CREATE POLICY "Members can view household members"
ON household_members FOR SELECT
TO authenticated
USING (
  (SELECT is_household_member(household_id))
);

-- Owner/Admin können Mitglieder hinzufügen
CREATE POLICY "Owners and admins can add members"
ON household_members FOR INSERT
TO authenticated
WITH CHECK (
  (SELECT can_manage_household(household_id))
  OR user_id = (SELECT auth.uid()) -- Nutzer kann sich selbst hinzufügen (bei Einladungsannahme)
);

-- Owner/Admin können Mitglieder aktualisieren (Rolle ändern, Status ändern)
CREATE POLICY "Owners and admins can update members"
ON household_members FOR UPDATE
TO authenticated
USING (
  (SELECT can_manage_household(household_id))
);

-- Owner/Admin können Mitglieder entfernen (außer Owner selbst)
CREATE POLICY "Owners and admins can remove members"
ON household_members FOR DELETE
TO authenticated
USING (
  (SELECT can_manage_household(household_id))
  AND role != 'owner' -- Owner kann nicht gelöscht werden
);

-- ============================================================================
-- 6. RLS POLICIES FÜR HOUSEHOLD_INVITATIONS
-- ============================================================================

-- Mitglieder können Einladungen ihres Haushalts sehen
CREATE POLICY "Members can view household invitations"
ON household_invitations FOR SELECT
TO authenticated
USING (
  (SELECT is_household_member(household_id))
  OR email = (SELECT get_my_email())
);

-- Owner/Admin können Einladungen erstellen
CREATE POLICY "Owners and admins can create invitations"
ON household_invitations FOR INSERT
TO authenticated
WITH CHECK (
  (SELECT can_manage_household(household_id))
);

-- Owner/Admin können Einladungen aktualisieren (widerrufen)
CREATE POLICY "Owners and admins can update invitations"
ON household_invitations FOR UPDATE
TO authenticated
USING (
  (SELECT can_manage_household(household_id))
  OR email = (SELECT get_my_email())
);

-- ============================================================================
-- 8. TRIGGER FÜR UPDATED_AT
-- ============================================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_households_updated_at
  BEFORE UPDATE ON households
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_household_members_updated_at
  BEFORE UPDATE ON household_members
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- FERTIG!
-- ============================================================================
-- Nach Ausführung dieses Skripts sind die Household-Tabellen bereit.
-- Stelle sicher, dass auch die bestehende 'backups' Tabelle korrekt
-- konfiguriert ist (siehe vorherige Dokumentation).
-- ============================================================================
