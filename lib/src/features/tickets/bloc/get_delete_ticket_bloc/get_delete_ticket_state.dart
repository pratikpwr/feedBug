part of 'get_delete_ticket_bloc.dart';

abstract class GetDeleteTicketState extends Equatable {
  const GetDeleteTicketState();

  @override
  List<Object> get props => [];
}

class GetTicketsInitial extends GetDeleteTicketState {}

class GetTicketsLoading extends GetDeleteTicketState {}

class GetTicketsSuccess extends GetDeleteTicketState {
  final List<Ticket> tickets;

  const GetTicketsSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class GetTicketsFailure extends GetDeleteTicketState {
  final FailureType type;

  const GetTicketsFailure(this.type);

  @override
  List<Object> get props => [type];
}
