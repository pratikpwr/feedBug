
import '../../../core/enums/flavors.dart';
import 'teams_model.dart';

class Project {
  final String title;
  final String description;
  final Flavors flavor;
  final List<Team> teams;

  const Project({
    required this.title,
    required this.description,
    required this.flavor,
    required this.teams,
  });
}
