import '../../../core/enums/flavors.dart';
import '../../../core/enums/ticket_enums.dart';
import '../../add_project/models/teams_model.dart';
import 'comment_model.dart';

class Ticket {
  final String title;
  final String? description;
  final String? improvement;

  final TicketType? ticketType;
  final Flavors flavor;
  final TicketPriority? priority;
  final TicketStatus status;

  final String? occurrenceModule;
  final String? occurrenceElement;

  final String? device;
  final String? deviceModel;

  final TeamMember createdBy;
  final TeamMember? assignedTo;

  final List<Comment> comments;

  // media attachments

  const Ticket({
    required this.title,
    this.description,
    this.improvement,
    this.ticketType,
    required this.flavor,
    this.priority,
    required this.status,
    this.occurrenceModule,
    this.occurrenceElement,
    this.device,
    this.deviceModel,
    required this.createdBy,
    this.assignedTo,
    required this.comments,
  });
}
