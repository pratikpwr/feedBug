import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:setuback/src/features/releases/models/release_model.dart';

import '../../../../core/enums/flavors.dart';
import '../../../projects/models/project_model.dart';

part 'release_state.dart';

class ReleaseCubit extends Cubit<ReleaseState> {
  ReleaseCubit(
    this.release,
  ) : super(const ReleaseState()) {
    _populateRelease(release);
  }

  final Release? release;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final buildLinkController = TextEditingController();

  void title(String title) {
    emit(state.copyWith(title: title));
  }

  void description(String description) {
    emit(state.copyWith(description: description));
  }

  void flavor(Flavor flavor) {
    emit(state.copyWith(flavor: flavor));
  }

  void buildLink(String buildLink) {
    emit(state.copyWith(buildLink: buildLink));
  }

  void isActive(bool isActive) {
    emit(state.copyWith(isActive: isActive));
  }

  void _populateRelease(Release? release) {
    if (release != null) {
      final newState = state.copyWith(
        title: release.title,
        description: release.description,
        flavor: release.flavor,
        buildLink: release.buildLink,
        isActive: release.isActive,
      );

      titleController.text = release.title;
      descriptionController.text = release.description ?? '';
      buildLinkController.text = release.buildLink ?? '';

      emit(newState);
    }
  }

  Release createRelease(Project project) {
    return Release(
      id: release?.id ?? '',
      title: state.title ?? '',
      description: state.description,
      flavor: state.flavor,
      buildLink: state.buildLink,
      isActive: state.isActive,
      projectId: project.id,
      createdAt: release?.createdAt ?? Timestamp.now(),
      createdBy: 'AjFUaO5SKHz8O7uKaAuG',
    );
  }
}
