part of 'ticket_cubit.dart';

class TicketState extends Equatable {
  final String? title;
  final String? description;
  final TicketStatus? status;
  final TicketPriority? priority;
  final TicketType? ticketType;
  final String? improvement;
  final String? occurrenceModule;
  final String? occurrenceElement;
  final String? deviceName;
  final String? deviceModel;
  final String? mediaLink;

  const TicketState({
    this.title,
    this.description,
    this.priority,
    this.ticketType,
    this.status,
    this.improvement,
    this.occurrenceModule,
    this.occurrenceElement,
    this.deviceName,
    this.deviceModel,
    this.mediaLink,
  });

  TicketState copyWith({
    String? title,
    String? description,
    TicketPriority? priority,
    TicketType? ticketType,
    TicketStatus? status,
    String? improvement,
    String? occurrenceModule,
    String? occurrenceElement,
    String? deviceName,
    String? deviceModel,
    String? mediaLink,
  }) {
    return TicketState(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      ticketType: ticketType ?? this.ticketType,
      status: status ?? this.status,
      improvement: improvement ?? this.improvement,
      occurrenceModule: occurrenceModule ?? this.occurrenceModule,
      occurrenceElement: occurrenceElement ?? this.occurrenceElement,
      deviceName: deviceName ?? this.deviceName,
      deviceModel: deviceModel ?? this.deviceModel,
      mediaLink: mediaLink ?? this.mediaLink,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        priority,
        ticketType,
        status,
        improvement,
        occurrenceModule,
        occurrenceElement,
        deviceName,
        deviceModel,
        mediaLink,
      ];
}
