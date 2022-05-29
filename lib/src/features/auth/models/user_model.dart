import 'package:equatable/equatable.dart';

import '../../../core/enums/team_type.dart';
import '../../../core/enums/user.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? phone;
  final UserRoles? role;
  final List<String> skills;
  final double? experience;
  final String? position;
  final List<TeamType> teamType;

  const User({
    required this.id,
    required this.name,
    this.phone,
    this.role,
    this.skills = const [],
    this.experience,
    this.position,
    this.teamType = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        role,
        skills,
        experience,
        position,
        teamType,
      ];
}
