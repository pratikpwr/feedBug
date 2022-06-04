part of 'get_tickets_bloc.dart';

abstract class GetTicketsEvent extends Equatable {
  const GetTicketsEvent();
}

class GetTickets extends GetTicketsEvent {
  @override
  List<Object> get props => [];
}
