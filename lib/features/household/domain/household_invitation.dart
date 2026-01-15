import 'household_role.dart';

/// Status einer Einladung
enum InvitationStatus {
  /// Einladung ist aktiv und kann angenommen werden
  pending,
  
  /// Einladung wurde angenommen
  accepted,
  
  /// Einladung wurde widerrufen (vom Owner/Admin)
  revoked,
  
  /// Einladung ist abgelaufen
  expired,
}

/// Eine Einladung zu einem Haushalt
class HouseholdInvitation {
  final String inviteId;
  final String householdId;
  final String inviteToken;
  final String email;
  final HouseholdRole role;
  final InvitationStatus status;
  final String? message;
  final String createdBy;
  final DateTime createdAt;
  final DateTime expiresAt;

  /// Standard-Ablaufzeit: 7 Tage
  static const Duration defaultExpiration = Duration(days: 7);

  const HouseholdInvitation({
    required this.inviteId,
    required this.householdId,
    required this.inviteToken,
    required this.email,
    required this.role,
    required this.status,
    this.message,
    required this.createdBy,
    required this.createdAt,
    required this.expiresAt,
  });

  /// Prüft ob die Einladung noch gültig ist
  bool get isValid {
    if (status != InvitationStatus.pending) return false;
    return DateTime.now().isBefore(expiresAt);
  }

  /// Prüft ob die Einladung abgelaufen ist
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verbleibende Zeit bis zum Ablauf
  Duration get timeUntilExpiry => expiresAt.difference(DateTime.now());

  HouseholdInvitation copyWith({
    String? inviteId,
    String? householdId,
    String? inviteToken,
    String? email,
    HouseholdRole? role,
    InvitationStatus? status,
    String? message,
    String? createdBy,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return HouseholdInvitation(
      inviteId: inviteId ?? this.inviteId,
      householdId: householdId ?? this.householdId,
      inviteToken: inviteToken ?? this.inviteToken,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      message: message ?? this.message,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invite_id': inviteId,
      'household_id': householdId,
      'invite_token': inviteToken,
      'email': email,
      'role': role.name,
      'status': status.name,
      'message': message,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  factory HouseholdInvitation.fromJson(Map<String, dynamic> json) {
    return HouseholdInvitation(
      inviteId: json['invite_id'] as String,
      householdId: json['household_id'] as String,
      inviteToken: json['invite_token'] as String,
      email: json['email'] as String,
      role: HouseholdRole.values.firstWhere(
        (r) => r.name == json['role'],
        orElse: () => HouseholdRole.caregiver,
      ),
      status: InvitationStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => InvitationStatus.pending,
      ),
      message: json['message'] as String?,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdInvitation &&
          runtimeType == other.runtimeType &&
          inviteId == other.inviteId;

  @override
  int get hashCode => inviteId.hashCode;
}
