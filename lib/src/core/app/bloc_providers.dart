import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/projects/bloc/get_projects/get_projects_bloc.dart';
import 'injection_container.dart';

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<GetProjectsBloc>(
      create: (context) => sl<GetProjectsBloc>()..add(GetProjects()),
    ),
  ];
}
