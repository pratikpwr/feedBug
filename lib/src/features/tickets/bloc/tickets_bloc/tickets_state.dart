part of 'tickets_bloc.dart';

abstract class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object> get props => [];
}

class GetTicketsInitial extends TicketsState {}

class GetTicketsLoading extends TicketsState {}

class GetTicketsSuccess extends TicketsState {
  final List<Ticket> tickets;

  const GetTicketsSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class GetTicketsFailure extends TicketsState {
  final FailureType type;

  const GetTicketsFailure(this.type);

  @override
  List<Object> get props => [type];
}
