import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/enums/flavors.dart';
import '../../../core/enums/ticket_enums.dart';
import 'comment_model.dart';

class Ticket extends Equatable {
  final String id;
  final String title;
  final String projectId;
  final String releaseId;
  final Timestamp createdAt;

  final String? description;
  final String? improvement;

  final TicketType? ticketType;
  final Flavor? flavor;
  final TicketPriority? priority;
  final TicketStatus? status;

  final String? occurrenceModule;
  final String? occurrenceElement;

  final String? device;
  final String? deviceModel;

  final String createdBy;
  final String? assignedTo;

  final List<Comment> comments;

  final String? mediaLink;

  // media attachments

  const Ticket({
    required this.id,
    required this.title,
    required this.projectId,
    required this.releaseId,
    required this.createdAt,
    this.description,
    this.improvement,
    this.ticketType,
    this.flavor,
    this.priority,
    this.status,
    this.occurrenceModule,
    this.occurrenceElement,
    this.device,
    this.deviceModel,
    required this.createdBy,
    this.assignedTo,
    this.comments = const [],
    this.mediaLink,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        projectId,
        releaseId,
        description,
        improvement,
        ticketType,
        flavor,
        priority,
        status,
        occurrenceModule,
        occurrenceElement,
        device,
        deviceModel,
        createdBy,
        assignedTo,
        comments,
        mediaLink,
        createdAt,
      ];

  factory Ticket.fromJson(String id, Map<String, Object?> json) {
    return Ticket(
      id: id,
      title: json["title"]! as String,
      projectId: json["project_id"]! as String,
      releaseId: json["release_id"]! as String,
      createdAt: json["created_at"]! as Timestamp,
      description: json["description"]?.toString(),
      improvement: json["improvement"]?.toString(),
      ticketType: TicketType.fromString(json["ticket_type"]?.toString()),
      flavor: Flavor.fromString(json["flavor"]?.toString()),
      priority: TicketPriority.fromKey(json["priority"]?.toString()),
      status: TicketStatus.fromKey(json["status"]?.toString()),
      occurrenceModule: json["occurrence_module"]?.toString(),
      occurrenceElement: json["occurrence_element"]?.toString(),
      device: json["device"]?.toString(),
      deviceModel: json["device_model"]?.toString(),
      createdBy: json["created_by"]?.toString() ?? '',
      assignedTo: json["assigned_to"]?.toString() ?? '',
      mediaLink: json["media_link"]?.toString(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'project_id': projectId,
      'release_id': releaseId,
      'description': description,
      'created_at': createdAt,
      'improvement': improvement,
      'ticket_type': ticketType?.toKey,
      'flavor': flavor?.toKey,
      'priority': priority?.toKey,
      'status': status?.toKey,
      'occurrence_module': occurrenceModule,
      'occurrence_element': occurrenceElement,
      'device': device,
      'device_model': deviceModel,
      'created_by': createdBy,
      'assigned_to': assignedTo,
      'media_link': mediaLink,
    };
  }
}
