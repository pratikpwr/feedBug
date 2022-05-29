import 'package:equatable/equatable.dart';

import '../../../core/enums/flavors.dart';
import '../../../core/enums/team_type.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String? description;
  final List<Flavor>? flavor;
  final List<TeamType> teams;

  const Project({
    required this.id,
    required this.title,
    this.description,
    this.flavor = const [],
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

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      flavor: List<Flavor>.from(
          json["flavors"].map((f) => Flavor.fromString(f)).toList()),
      teams: List<TeamType>.from(
          json["teams"].map((t) => TeamType.fromString(t)).toList()),
    );
  }
}
