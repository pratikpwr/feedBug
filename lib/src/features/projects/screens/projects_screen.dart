import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/views/widgets/loader.dart';
import 'package:setuback/src/core/views/widgets/unknown_state.dart';
import 'package:setuback/src/features/projects/bloc/get_projects/get_projects_bloc.dart';

import '../../../core/views/widgets/failure_view.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<GetProjectsBloc, GetProjectsState>(
          builder: (context, state) {
            if (state is GetProjectsLoading) {
              return const Loader();
            }
            if (state is GetProjectsSuccess) {
              return Center(
                child: Text(state.projects.first.title),
              );
            }
            if (state is GetProjectsFailure) {
              return FailureView(type: state.type);
            }
            return const UnKnownState();
          },
        ),
      ),
    );
  }
}
