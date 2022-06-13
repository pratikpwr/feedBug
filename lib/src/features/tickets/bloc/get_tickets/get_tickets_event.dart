part of 'get_tickets_bloc.dart';

abstract class GetTicketsEvent extends Equatable {
  const GetTicketsEvent();
}

class GetTickets extends GetTicketsEvent {
  final String releaseId;

  const GetTickets({
    required this.releaseId,
  });

  @override
  List<Object> get props => [releaseId];
}
