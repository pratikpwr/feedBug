part of 'get_delete_ticket_bloc.dart';

abstract class GetDeleteTicketEvent extends Equatable {
  const GetDeleteTicketEvent();
}

class GetTickets extends GetDeleteTicketEvent {
  final String releaseId;

  const GetTickets({
    required this.releaseId,
  });

  @override
  List<Object> get props => [releaseId];
}

class DeleteTicket extends GetDeleteTicketEvent {
  final String ticketId;

  const DeleteTicket({
    required this.ticketId,
  });

  @override
  List<Object> get props => [ticketId];
}
