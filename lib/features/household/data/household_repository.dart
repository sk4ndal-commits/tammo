import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/household.dart';
import '../domain/household_member.dart';
import '../domain/household_invitation.dart';
import '../domain/household_role.dart';

class HouseholdRepository {
  final SupabaseClient _supabase;

  HouseholdRepository(this._supabase);

  // ============================================================================
  // Household CRUD
  // ============================================================================

  /// Erstellt einen neuen Haushalt und fügt den Ersteller als Owner hinzu
  Future<Household> createHousehold(String name) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Nicht eingeloggt');

    final householdId = _generateUuid();
    final now = DateTime.now();

    // Haushalt erstellen
    await _supabase.from('households').insert({
      'household_id': householdId,
      'name': name,
      'created_by': user.id,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    });

    // Ersteller als Owner hinzufügen
    await _supabase.from('household_members').insert({
      'member_id': _generateUuid(),
      'household_id': householdId,
      'user_id': user.id,
      'email': user.email,
      'display_name': user.userMetadata?['display_name'] as String?,
      'role': HouseholdRole.owner.name,
      'status': MemberStatus.active.name,
      'joined_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    });

    return Household(
      householdId: householdId,
      name: name,
      createdBy: user.id,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Lädt den Haushalt des aktuellen Nutzers (MVP: ein Haushalt pro Nutzer)
  Future<HouseholdWithMembers?> getCurrentUserHousehold() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    // Finde den Haushalt, in dem der Nutzer Mitglied ist
    final memberResponse = await _supabase
        .from('household_members')
        .select('household_id')
        .eq('user_id', user.id)
        .eq('status', 'active')
        .maybeSingle();

    if (memberResponse == null) return null;

    final householdId = memberResponse['household_id'] as String;
    return getHouseholdWithMembers(householdId);
  }

  /// Lädt einen Haushalt mit allen Mitgliedern
  Future<HouseholdWithMembers?> getHouseholdWithMembers(String householdId) async {
    final householdResponse = await _supabase
        .from('households')
        .select()
        .eq('household_id', householdId)
        .maybeSingle();

    if (householdResponse == null) return null;

    final membersResponse = await _supabase
        .from('household_members')
        .select()
        .eq('household_id', householdId)
        .neq('status', 'removed');

    final household = Household.fromJson(householdResponse);
    final members = (membersResponse as List)
        .map((m) => HouseholdMember.fromJson(m as Map<String, dynamic>))
        .toList();

    return HouseholdWithMembers(household: household, members: members);
  }

  /// Aktualisiert den Namen eines Haushalts
  Future<void> updateHouseholdName(String householdId, String newName) async {
    await _supabase
        .from('households')
        .update({
          'name': newName,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('household_id', householdId);
  }

  // ============================================================================
  // Member Management
  // ============================================================================

  /// Holt die Rolle des aktuellen Nutzers in einem Haushalt
  Future<HouseholdRole?> getCurrentUserRole(String householdId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final response = await _supabase
        .from('household_members')
        .select('role')
        .eq('household_id', householdId)
        .eq('user_id', user.id)
        .eq('status', 'active')
        .maybeSingle();

    if (response == null) return null;

    return HouseholdRole.values.firstWhere(
      (r) => r.name == response['role'],
      orElse: () => HouseholdRole.caregiver,
    );
  }

  /// Ändert die Rolle eines Mitglieds
  Future<void> updateMemberRole(String memberId, HouseholdRole newRole) async {
    await _supabase
        .from('household_members')
        .update({
          'role': newRole.name,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('member_id', memberId);
  }

  /// Entfernt ein Mitglied aus dem Haushalt (setzt Status auf 'removed')
  Future<void> removeMember(String memberId) async {
    await _supabase
        .from('household_members')
        .update({
          'status': MemberStatus.removed.name,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('member_id', memberId);
  }

  // ============================================================================
  // Invitation Management
  // ============================================================================

  /// Erstellt eine neue Einladung
  Future<HouseholdInvitation> createInvitation({
    required String householdId,
    required String email,
    HouseholdRole role = HouseholdRole.caregiver,
    String? message,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Nicht eingeloggt');

    // Prüfe ob E-Mail bereits Mitglied ist
    final existingMember = await _supabase
        .from('household_members')
        .select('member_id')
        .eq('household_id', householdId)
        .eq('email', email)
        .eq('status', 'active')
        .maybeSingle();

    if (existingMember != null) {
      throw Exception('Diese Person ist bereits Mitglied des Haushalts');
    }

    final inviteId = _generateUuid();
    final inviteToken = _generateInviteToken();
    final now = DateTime.now();
    final expiresAt = now.add(HouseholdInvitation.defaultExpiration);

    await _supabase.from('household_invitations').insert({
      'invite_id': inviteId,
      'household_id': householdId,
      'invite_token': inviteToken,
      'email': email,
      'role': role.name,
      'status': InvitationStatus.pending.name,
      'message': message,
      'created_by': user.id,
      'created_at': now.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
    });

    return HouseholdInvitation(
      inviteId: inviteId,
      householdId: householdId,
      inviteToken: inviteToken,
      email: email,
      role: role,
      status: InvitationStatus.pending,
      message: message,
      createdBy: user.id,
      createdAt: now,
      expiresAt: expiresAt,
    );
  }

  /// Lädt alle offenen Einladungen für einen Haushalt
  Future<List<HouseholdInvitation>> getHouseholdInvitations(String householdId) async {
    final response = await _supabase
        .from('household_invitations')
        .select()
        .eq('household_id', householdId)
        .eq('status', 'pending');

    return (response as List)
        .map((i) => HouseholdInvitation.fromJson(i as Map<String, dynamic>))
        .toList();
  }

  /// Lädt Einladungen für die E-Mail des aktuellen Nutzers
  Future<List<HouseholdInvitation>> getMyPendingInvitations() async {
    final user = _supabase.auth.currentUser;
    if (user == null || user.email == null) return [];

    final response = await _supabase
        .from('household_invitations')
        .select()
        .eq('email', user.email!)
        .eq('status', 'pending');

    return (response as List)
        .map((i) => HouseholdInvitation.fromJson(i as Map<String, dynamic>))
        .where((i) => i.isValid)
        .toList();
  }

  /// Nimmt eine Einladung an
  Future<void> acceptInvitation(String inviteToken) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Nicht eingeloggt');

    // Lade die Einladung
    final inviteResponse = await _supabase
        .from('household_invitations')
        .select()
        .eq('invite_token', inviteToken)
        .eq('status', 'pending')
        .maybeSingle();

    if (inviteResponse == null) {
      throw Exception('Einladung ungültig oder abgelaufen');
    }

    final invitation = HouseholdInvitation.fromJson(inviteResponse);

    if (!invitation.isValid) {
      throw Exception('Einladung ist abgelaufen');
    }

    // Prüfe ob Nutzer bereits in einem Haushalt ist (MVP: ein Haushalt pro Nutzer)
    final existingMembership = await _supabase
        .from('household_members')
        .select('member_id')
        .eq('user_id', user.id)
        .eq('status', 'active')
        .maybeSingle();

    if (existingMembership != null) {
      throw Exception('Du bist bereits Mitglied eines Haushalts');
    }

    final now = DateTime.now();

    // Mitglied hinzufügen
    await _supabase.from('household_members').insert({
      'member_id': _generateUuid(),
      'household_id': invitation.householdId,
      'user_id': user.id,
      'email': user.email,
      'display_name': user.userMetadata?['display_name'] as String?,
      'role': invitation.role.name,
      'status': MemberStatus.active.name,
      'joined_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    });

    // Einladung als angenommen markieren
    await _supabase
        .from('household_invitations')
        .update({'status': InvitationStatus.accepted.name})
        .eq('invite_id', invitation.inviteId);
  }

  /// Widerruft eine Einladung
  Future<void> revokeInvitation(String inviteId) async {
    await _supabase
        .from('household_invitations')
        .update({'status': InvitationStatus.revoked.name})
        .eq('invite_id', inviteId);
  }

  // ============================================================================
  // Helpers
  // ============================================================================

  String _generateUuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  String _generateInviteToken() {
    final random = Random.secure();
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(32, (_) => chars[random.nextInt(chars.length)]).join();
  }
}
