import '../../../core/enums/team_type.dart';
import '../../auth/models/user_model.dart';

class Team {
  final String title;
  final TeamType type;
  final TeamMember? teamLead;
  final List<TeamMember> teamMembers;

  const Team({
    required this.title,
    required this.type,
    this.teamLead,
    required this.teamMembers,
  });
}

class TeamMember {
  final User member;
  final String? skills;
  final String? experience;
  final TeamType teamType;

  const TeamMember({
    required this.member,
    this.skills,
    this.experience,
    required this.teamType,
  });
}

