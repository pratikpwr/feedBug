part of 'create_ticket_cubit.dart';

class CreateTicketState extends Equatable {
  final String? title;
  final titleController = TextEditingController();
  final String? description;
  final descriptionController = TextEditingController();
  final TicketPriority? priority;
  final TicketType? ticketType;
  final String? improvement;
  final improvementController = TextEditingController();
  final String? occurrenceModel;
  final occurrenceModelController = TextEditingController();
  final String? occurrenceElement;
  final occurrenceElementController = TextEditingController();
  final String? deviceName;
  final deviceNameController = TextEditingController();
  final String? deviceModel;
  final deviceModelController = TextEditingController();

  CreateTicketState({
    this.title,
    this.description,
    this.priority,
    this.ticketType,
    this.improvement,
    this.occurrenceModel,
    this.occurrenceElement,
    this.deviceName,
    this.deviceModel,
  });

  CreateTicketState copyWith({
    String? title,
    String? description,
    TicketPriority? priority,
    TicketType? ticketType,
    String? improvement,
    String? occurrenceModel,
    String? occurrenceElement,
    String? deviceName,
    String? deviceModel,
  }) {
    return CreateTicketState(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      ticketType: ticketType ?? this.ticketType,
      improvement: improvement ?? this.improvement,
      occurrenceModel: occurrenceModel ?? this.occurrenceModel,
      occurrenceElement: occurrenceElement ?? this.occurrenceElement,
      deviceName: deviceName ?? this.deviceName,
      deviceModel: deviceModel ?? this.deviceModel,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        priority,
        ticketType,
        improvement,
        occurrenceModel,
        occurrenceElement,
        deviceName,
        deviceModel,
      ];
}
