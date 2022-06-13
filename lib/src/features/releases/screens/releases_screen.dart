import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../../projects/models/project_model.dart';
import '../../tickets/screens/tickets_screen.dart';
import '../bloc/get_releases/get_releases_bloc.dart';
import '../models/release_model.dart';

class ReleasesScreen extends StatelessWidget {
  final Project project;

  const ReleasesScreen({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetReleasesBloc(repository: sl())
        ..add(GetReleases(projectId: project.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Releases in ${project.title}',
              maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<GetReleasesBloc, GetReleasesState>(
            builder: (context, state) {
              if (state is GetReleasesLoading) {
                return const Loader();
              }
              if (state is GetReleasesSuccess) {
                return ReleasesWidget(releases: state.releases);
              }
              if (state is GetReleasesFailure) {
                return FailureView(
                  type: state.type,
                  onRetry: () {
                    BlocProvider.of<GetReleasesBloc>(context)
                        .add(GetReleases(projectId: project.id));
                  },
                );
              }
              return const UnKnownState();
            },
          ),
        ),
      ),
    );
  }
}

class ReleasesWidget extends StatelessWidget {
  final List<Release> releases;

  const ReleasesWidget({Key? key, required this.releases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: releases.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final release = releases[index];
          return ListTile(
            title: Text(release.title),
            subtitle: Text(release.description ?? ''),
            trailing: Text(release.flavor.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketsScreen(release: release),
                ),
              );
            },
          );
        });
  }
}
