import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/household_repository.dart';
import '../domain/household.dart';
import '../domain/household_member.dart';
import '../domain/household_invitation.dart';
import '../domain/household_role.dart';
import '../../backup/data/supabase_provider.dart';

// ============================================================================
// Providers
// ============================================================================

final householdRepositoryProvider = Provider<HouseholdRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return HouseholdRepository(supabase);
});

/// Provider für den aktuellen Haushalt des Nutzers
final currentHouseholdProvider = FutureProvider<HouseholdWithMembers?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  
  final repository = ref.watch(householdRepositoryProvider);
  return repository.getCurrentUserHousehold();
});

/// Provider für die Rolle des aktuellen Nutzers im Haushalt
final currentUserRoleProvider = FutureProvider<HouseholdRole?>((ref) async {
  final household = await ref.watch(currentHouseholdProvider.future);
  if (household == null) return null;
  
  final repository = ref.watch(householdRepositoryProvider);
  return repository.getCurrentUserRole(household.household.householdId);
});

/// Provider für offene Einladungen des aktuellen Nutzers
final myPendingInvitationsProvider = FutureProvider<List<HouseholdInvitation>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  
  final repository = ref.watch(householdRepositoryProvider);
  return repository.getMyPendingInvitations();
});

/// Provider für Einladungen des aktuellen Haushalts
final householdInvitationsProvider = FutureProvider<List<HouseholdInvitation>>((ref) async {
  final household = await ref.watch(currentHouseholdProvider.future);
  if (household == null) return [];
  
  final repository = ref.watch(householdRepositoryProvider);
  return repository.getHouseholdInvitations(household.household.householdId);
});

// ============================================================================
// Household Service
// ============================================================================

final householdServiceProvider = Provider<HouseholdService>((ref) {
  return HouseholdService(ref);
});

class HouseholdService {
  final Ref _ref;

  HouseholdService(this._ref);

  HouseholdRepository get _repository => _ref.read(householdRepositoryProvider);

  /// Erstellt einen neuen Haushalt
  Future<Household> createHousehold(String name) async {
    final household = await _repository.createHousehold(name);
    _ref.invalidate(currentHouseholdProvider);
    return household;
  }

  /// Aktualisiert den Namen des Haushalts
  Future<void> updateHouseholdName(String householdId, String newName) async {
    await _repository.updateHouseholdName(householdId, newName);
    _ref.invalidate(currentHouseholdProvider);
  }

  /// Lädt eine Person per E-Mail ein
  Future<HouseholdInvitation> inviteMember({
    required String email,
    HouseholdRole role = HouseholdRole.caregiver,
    String? message,
  }) async {
    final household = await _ref.read(currentHouseholdProvider.future);
    if (household == null) {
      throw Exception('Kein Haushalt vorhanden');
    }

    final invitation = await _repository.createInvitation(
      householdId: household.household.householdId,
      email: email,
      role: role,
      message: message,
    );

    _ref.invalidate(householdInvitationsProvider);
    return invitation;
  }

  /// Nimmt eine Einladung an
  Future<void> acceptInvitation(String inviteToken) async {
    await _repository.acceptInvitation(inviteToken);
    _ref.invalidate(currentHouseholdProvider);
    _ref.invalidate(myPendingInvitationsProvider);
  }

  /// Widerruft eine Einladung
  Future<void> revokeInvitation(String inviteId) async {
    await _repository.revokeInvitation(inviteId);
    _ref.invalidate(householdInvitationsProvider);
  }

  /// Ändert die Rolle eines Mitglieds
  Future<void> updateMemberRole(String memberId, HouseholdRole newRole) async {
    await _repository.updateMemberRole(memberId, newRole);
    _ref.invalidate(currentHouseholdProvider);
  }

  /// Entfernt ein Mitglied aus dem Haushalt
  Future<void> removeMember(String memberId) async {
    await _repository.removeMember(memberId);
    _ref.invalidate(currentHouseholdProvider);
  }

  /// Prüft ob der aktuelle Nutzer Mitglieder verwalten darf
  Future<bool> canManageMembers() async {
    final role = await _ref.read(currentUserRoleProvider.future);
    return role?.canManageMembers ?? false;
  }

  /// Prüft ob der aktuelle Nutzer Pläne verwalten darf
  Future<bool> canManagePlans() async {
    final role = await _ref.read(currentUserRoleProvider.future);
    return role?.canManagePlans ?? false;
  }

  /// Prüft ob der aktuelle Nutzer Pets verwalten darf
  Future<bool> canManagePets() async {
    final role = await _ref.read(currentUserRoleProvider.future);
    return role?.canManagePets ?? false;
  }

  /// Prüft ob der aktuelle Nutzer Dokumente verwalten darf
  Future<bool> canManageDocuments() async {
    final role = await _ref.read(currentUserRoleProvider.future);
    return role?.canManageDocuments ?? false;
  }

  /// Prüft ob der aktuelle Nutzer Check-ins durchführen darf
  Future<bool> canPerformCheckIns() async {
    final role = await _ref.read(currentUserRoleProvider.future);
    return role?.canPerformCheckIns ?? true; // Default: ja (auch ohne Haushalt)
  }

  /// Holt den Anzeigenamen des aktuellen Nutzers für Attribution
  String? getCurrentUserDisplayName() {
    final user = _ref.read(currentUserProvider);
    if (user == null) return null;
    return user.userMetadata?['display_name'] as String? ?? user.email;
  }
}
