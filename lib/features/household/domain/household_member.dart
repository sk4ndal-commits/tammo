import 'household_role.dart';

/// Status eines Haushaltsmitglieds
enum MemberStatus {
  /// Einladung wurde gesendet, aber noch nicht angenommen
  pending,
  
  /// Mitglied ist aktiv und hat Zugriff
  active,
  
  /// Mitglied wurde entfernt (für Audit-Trail)
  removed,
}

/// Ein Mitglied eines Haushalts
class HouseholdMember {
  final String memberId;
  final String householdId;
  final String userId;
  final String? email;
  final String? displayName;
  final HouseholdRole role;
  final MemberStatus status;
  final DateTime joinedAt;
  final DateTime updatedAt;

  const HouseholdMember({
    required this.memberId,
    required this.householdId,
    required this.userId,
    this.email,
    this.displayName,
    required this.role,
    required this.status,
    required this.joinedAt,
    required this.updatedAt,
  });

  /// Anzeigename für UI (E-Mail als Fallback)
  String get displayNameOrEmail => displayName ?? email ?? 'Unbekannt';

  /// Initialen für Avatar-Anzeige
  String get initials {
    final name = displayName ?? email ?? '?';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  HouseholdMember copyWith({
    String? memberId,
    String? householdId,
    String? userId,
    String? email,
    String? displayName,
    HouseholdRole? role,
    MemberStatus? status,
    DateTime? joinedAt,
    DateTime? updatedAt,
  }) {
    return HouseholdMember(
      memberId: memberId ?? this.memberId,
      householdId: householdId ?? this.householdId,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'household_id': householdId,
      'user_id': userId,
      'email': email,
      'display_name': displayName,
      'role': role.name,
      'status': status.name,
      'joined_at': joinedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory HouseholdMember.fromJson(Map<String, dynamic> json) {
    return HouseholdMember(
      memberId: json['member_id'] as String,
      householdId: json['household_id'] as String,
      userId: json['user_id'] as String,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      role: HouseholdRole.values.firstWhere(
        (r) => r.name == json['role'],
        orElse: () => HouseholdRole.caregiver,
      ),
      status: MemberStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => MemberStatus.pending,
      ),
      joinedAt: DateTime.parse(json['joined_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdMember &&
          runtimeType == other.runtimeType &&
          memberId == other.memberId;

  @override
  int get hashCode => memberId.hashCode;
}
