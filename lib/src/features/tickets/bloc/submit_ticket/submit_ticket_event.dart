part of 'submit_ticket_bloc.dart';

abstract class SubmitTicketEvent extends Equatable {
  const SubmitTicketEvent();
}

class SubmitTicket extends SubmitTicketEvent {
  final Ticket ticket;

  const SubmitTicket({required this.ticket});

  @override
  List<Object> get props => [ticket];
}

class UpdateTicket extends SubmitTicketEvent {
  final Ticket ticket;

  const UpdateTicket({required this.ticket});

  @override
  List<Object> get props => [ticket];
}
