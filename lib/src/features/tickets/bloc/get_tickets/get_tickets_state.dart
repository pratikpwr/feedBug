part of 'get_tickets_bloc.dart';

abstract class GetTicketsState extends Equatable {
  const GetTicketsState();

  @override
  List<Object> get props => [];
}

class GetTicketsInitial extends GetTicketsState {}

class GetTicketsLoading extends GetTicketsState {}

class GetTicketsSuccess extends GetTicketsState {
  final List<Ticket> tickets;

  const GetTicketsSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class GetTicketsFailure extends GetTicketsState {
  final FailureType type;

  const GetTicketsFailure(this.type);

  @override
  List<Object> get props => [type];
}
