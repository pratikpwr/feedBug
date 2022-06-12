import 'package:equatable/equatable.dart';

import '../../../core/enums/flavors.dart';
import '../../../core/enums/team_type.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String? imageUrl;
  final String? description;
  final List<Flavor>? flavor;
  final List<TeamType> teams;

  const Project({
    required this.id,
    required this.title,
    this.imageUrl,
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

  factory Project.fromJson(String id, Map<String, Object?> json) {
    return Project(
      id: id,
      title: json["title"]! as String,
      imageUrl: json["image_url"]?.toString(),
      description: json["description"]?.toString(),
      // flavor: (json["flavor"] as List<dynamic>)
      //     .map((e) => Flavor.values[e])
      //     .toList(),
      // teams: (json["teams"] as List<dynamic>)
      //     .map((e) => TeamType.values[e])
      //     .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      'title': title,
      'image_url': imageUrl,
      'description': description,
      'flavor': flavor?.map((e) => e.index).toList(),
      'teams': teams.map((e) => e.index).toList(),
    };
  }
}
