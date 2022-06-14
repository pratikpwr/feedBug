part of 'create_update_ticket_bloc.dart';

abstract class CreateUpdateTicketEvent extends Equatable {
  const CreateUpdateTicketEvent();
}

class SubmitTicket extends CreateUpdateTicketEvent {
  final Ticket ticket;

  const SubmitTicket({required this.ticket});

  @override
  List<Object> get props => [ticket];
}

class UpdateTicket extends CreateUpdateTicketEvent {
  final Ticket ticket;

  const UpdateTicket({required this.ticket});

  @override
  List<Object> get props => [ticket];
}
