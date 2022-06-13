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

  const Release({
    required this.id,
    required this.title,
    required this.projectId,
    this.description,
    required this.createdAt,
    required this.isActive,
    required this.flavor,
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
      ];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'project_id': projectId,
      'description': description,
      'created_at': createdAt,
      'is_active': isActive,
      'flavor': flavor.toKey,
    };
  }

  factory Release.fromJson(String id, Map<String, Object?> json) {
    return Release(
      id: id,
      title: json['title'] as String,
      projectId: json['project_id'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as Timestamp,
      isActive: json['is_active'] as bool,
      flavor: Flavor.fromString(json['flavor'] as String) ?? Flavor.dev,
    );
  }
}
