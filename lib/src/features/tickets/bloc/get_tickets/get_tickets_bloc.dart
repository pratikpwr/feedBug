import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';
import 'package:setuback/src/features/tickets/repository/ticket_repository.dart';

import '../../../../core/errors/failure_types.dart';

part 'get_tickets_event.dart';

part 'get_tickets_state.dart';

class GetTicketsBloc extends Bloc<GetTicketsEvent, GetTicketsState> {
  final TicketRepository repository;

  final List<Ticket> tickets = [];

  GetTicketsBloc({
    required this.repository,
  }) : super(GetTicketsInitial()) {
    on<GetTickets>(_onGetTicketsEvent);
    on<DeleteTicket>(_onDeleteTicketEvent);
  }

  void _onGetTicketsEvent(
    GetTickets event,
    Emitter<GetTicketsState> emit,
  ) async {
    emit(GetTicketsLoading());

    final result = await repository.getTickets(event.releaseId);

    result.fold(
      (failure) => emit(GetTicketsFailure(FailureType.fromFailure(failure))),
      (ticketsData) {
        tickets.addAll(ticketsData);
        emit(GetTicketsSuccess(tickets));
      },
    );
  }

  void _onDeleteTicketEvent(
    DeleteTicket event,
    Emitter<GetTicketsState> emit,
  ) async {
    emit(GetTicketsLoading());

    final result = await repository.deleteTicket(event.ticketId);

    result.fold(
      (failure) => emit(GetTicketsFailure(FailureType.fromFailure(failure))),
      (_) {
        tickets.removeWhere((ticket) => ticket.id == event.ticketId);
        emit(GetTicketsSuccess(tickets));
      },
    );
  }
}
