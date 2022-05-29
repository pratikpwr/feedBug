import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/views/widgets/loader.dart';
import 'package:setuback/src/core/views/widgets/unknown_state.dart';
import 'package:setuback/src/features/projects/bloc/get_projects/get_projects_bloc.dart';

import '../../../core/views/widgets/failure_view.dart';
import '../models/project_model.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GetProjectsBloc, GetProjectsState>(
          builder: (context, state) {
            if (state is GetProjectsLoading) {
              return const Loader();
            }
            if (state is GetProjectsSuccess) {
              return ProjectsWidget(projects: state.projects);
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

class ProjectsWidget extends StatelessWidget {
  final List<Project> projects;

  const ProjectsWidget({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: projects.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final project = projects[index];
          return ListTile(
            leading: project.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: project.imageUrl!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(),
            title: Text(project.title),
            subtitle: Text(project.description ?? ''),
          );
        });
  }
}
