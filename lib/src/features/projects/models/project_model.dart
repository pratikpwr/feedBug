import 'package:equatable/equatable.dart';

import '../../../core/enums/flavors.dart';
import '../../../core/enums/team_type.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String? description;
  final Flavors? flavor;
  final List<TeamType> teams;

  const Project({
    required this.id,
    required this.title,
    this.description,
    required this.flavor,
    this.teams = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        flavor,
        teams,
      ];
}
