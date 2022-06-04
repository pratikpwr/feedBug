part of 'create_ticket_cubit.dart';

class CreateTicketState extends Equatable {
  final String? title;
  final String? description;
  final TicketPriority? priority;
  final TicketType? ticketType;
  final String? improvment;
  final String? occurrenceModel;
  final String? occurrenceElement;
  final String? deviceName;
  final String? deviceModel;

  const CreateTicketState({
    this.title,
    this.description,
    this.priority,
    this.ticketType,
    this.improvment,
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
    String? improvment,
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
      improvment: improvment ?? this.improvment,
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
        improvment,
        occurrenceModel,
        occurrenceElement,
        deviceName,
        deviceModel,
      ];
}
