import 'household_member.dart';

/// Ein Household ist die Einheit, in der Personen zusammenarbeiten.
/// Alle Pets, Pläne und Tasks sind über Pet→Household für alle Mitglieder sichtbar.
class Household {
  final String householdId;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Household({
    required this.householdId,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Household copyWith({
    String? householdId,
    String? name,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Household(
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'household_id': householdId,
      'name': name,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      householdId: json['household_id'] as String,
      name: json['name'] as String,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Household &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId;

  @override
  int get hashCode => householdId.hashCode;
}

/// Erweitertes Household-Modell mit Mitgliedern für UI-Anzeige
class HouseholdWithMembers {
  final Household household;
  final List<HouseholdMember> members;

  const HouseholdWithMembers({
    required this.household,
    required this.members,
  });

  /// Findet den Owner des Haushalts
  HouseholdMember? get owner {
    try {
      return members.firstWhere((m) => m.role.name == 'owner');
    } catch (_) {
      return null;
    }
  }

  /// Anzahl der aktiven Mitglieder
  int get activeMemberCount {
    return members.where((m) => m.status == MemberStatus.active).length;
  }
}
