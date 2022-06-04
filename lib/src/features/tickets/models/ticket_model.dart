import 'package:equatable/equatable.dart';

import '../../../core/enums/flavors.dart';
import '../../../core/enums/ticket_enums.dart';
import 'comment_model.dart';

class Ticket extends Equatable {
  final String id;
  final String title;
  final String projectId;

  final String? description;
  final String? improvement;

  final TicketType? ticketType;
  final Flavor? flavor;
  final TicketPriority? priority;
  final TicketStatus status;

  final String? occurrenceModule;
  final String? occurrenceElement;

  final String? device;
  final String? deviceModel;

  final String createdBy;
  final String? assignedTo;

  final List<Comment> comments;

  // media attachments

  const Ticket({
    required this.id,
    required this.title,
    required this.projectId,
    this.description,
    this.improvement,
    this.ticketType,
    this.flavor,
    this.priority,
    required this.status,
    this.occurrenceModule,
    this.occurrenceElement,
    this.device,
    this.deviceModel,
    required this.createdBy,
    this.assignedTo,
    this.comments = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        projectId,
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
      ];

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json["id"],
      title: json["title"],
      projectId: json["project"],
      description: json["description"],
      improvement: json["improvement"],
      ticketType: TicketType.fromString(json["ticket_type"]),
      flavor: Flavor.fromString(json["flavor"]),
      priority: TicketPriority.fromString(json["priority"]),
      status: TicketStatus.created,
      occurrenceModule: json["occurrence_module"],
      occurrenceElement: json["occurrence_element"],
      device: json["device"],
      deviceModel: json["device_model"],
      createdBy: json["created_by"],
      assignedTo: json["assigned_to"],
    );
  }
}
