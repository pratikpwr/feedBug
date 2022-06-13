part of 'tickets_bloc.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();
}

class GetTickets extends TicketsEvent {
  final String releaseId;

  const GetTickets({
    required this.releaseId,
  });

  @override
  List<Object> get props => [releaseId];
}

class DeleteTicket extends TicketsEvent {
  final String ticketId;

  const DeleteTicket({
    required this.ticketId,
  });

  @override
  List<Object> get props => [ticketId];
}
