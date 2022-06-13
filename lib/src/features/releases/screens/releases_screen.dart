import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/views/widgets/loader.dart';
import 'package:setuback/src/core/views/widgets/unknown_state.dart';
import 'package:setuback/src/features/tickets/screens/tickets_screen.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../bloc/get_releases/get_releases_bloc.dart';
import '../models/release_model.dart';

class ReleasesScreen extends StatelessWidget {
  final String projectId;

  const ReleasesScreen({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetReleasesBloc(repository: sl())
        ..add(GetReleases(projectId: projectId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Releases'),
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
                        .add(GetReleases(projectId: projectId));
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
                  builder: (context) => TicketsScreen(releaseId: release.id),
                ),
              );
            },
          );
        });
  }
}
