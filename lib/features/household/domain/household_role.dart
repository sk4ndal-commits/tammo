/// Rollen innerhalb eines Haushalts (MVP)
enum HouseholdRole {
  /// Genau 1 pro Household - volle Rechte inkl. Haushalt löschen
  owner,
  
  /// Optional, mehrere möglich - fast alle Rechte außer Owner-Transfer
  admin,
  
  /// Standard-Rolle - kann Tasks erledigen, Symptome loggen, Dokumente ansehen
  caregiver,
}

extension HouseholdRoleExtension on HouseholdRole {
  String get displayName {
    switch (this) {
      case HouseholdRole.owner:
        return 'Owner';
      case HouseholdRole.admin:
        return 'Admin';
      case HouseholdRole.caregiver:
        return 'Caregiver';
    }
  }

  /// Prüft ob diese Rolle Mitglieder verwalten darf
  bool get canManageMembers {
    return this == HouseholdRole.owner || this == HouseholdRole.admin;
  }

  /// Prüft ob diese Rolle Pläne erstellen/bearbeiten/löschen darf
  bool get canManagePlans {
    return this == HouseholdRole.owner || this == HouseholdRole.admin;
  }

  /// Prüft ob diese Rolle Pets hinzufügen/entfernen darf
  bool get canManagePets {
    return this == HouseholdRole.owner || this == HouseholdRole.admin;
  }

  /// Prüft ob diese Rolle Dokumente hochladen/löschen darf
  bool get canManageDocuments {
    return this == HouseholdRole.owner || this == HouseholdRole.admin;
  }

  /// Prüft ob diese Rolle Exporte erstellen darf
  bool get canExport {
    return this == HouseholdRole.owner || this == HouseholdRole.admin;
  }

  /// Prüft ob diese Rolle Check-ins durchführen darf
  bool get canPerformCheckIns => true;

  /// Prüft ob diese Rolle Symptome loggen darf
  bool get canLogSymptoms => true;

  /// Prüft ob diese Rolle Dokumente ansehen darf
  bool get canViewDocuments => true;
}
