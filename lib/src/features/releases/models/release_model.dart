import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/enums/flavors.dart';

class Release extends Equatable {
  final String id;
  final String title;
  final String projectId;
  final String? description;
  final Timestamp createdAt;
  final bool isActive;
  final Flavor flavor;
  final String? buildLink;
  final String createdBy;

  const Release({
    required this.id,
    required this.title,
    required this.projectId,
    this.description,
    required this.createdAt,
    required this.isActive,
    required this.flavor,
    this.buildLink,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        projectId,
        description,
        createdAt,
        isActive,
        flavor,
        buildLink,
      ];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'project_id': projectId,
      'description': description,
      'created_at': createdAt,
      'is_active': isActive,
      'flavor': flavor.toKey,
      'build_link': buildLink,
      'created_by': createdBy,
    };
  }

  factory Release.fromJson(String id, Map<String, Object?> json) {
    return Release(
      id: id,
      title: json['title'] as String,
      projectId: json['project_id'] as String,
      description: json['description']?.toString(),
      createdAt: json['created_at'] as Timestamp,
      isActive: json['is_active'] as bool,
      flavor: Flavor.fromString(json['flavor'] as String) ?? Flavor.dev,
      buildLink: json['build_link']?.toString(),
      createdBy: json['created_by'] as String,
    );
  }
}
