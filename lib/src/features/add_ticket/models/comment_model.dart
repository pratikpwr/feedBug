import '../../add_project/models/teams_model.dart';

class Comment {
  final String comment;
  final TeamMember member;

  const Comment({
    required this.comment,
    required this.member,
  });
}
