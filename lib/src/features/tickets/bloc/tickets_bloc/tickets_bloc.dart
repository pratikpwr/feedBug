import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';
import 'package:setuback/src/features/tickets/repository/ticket_repository.dart';

import '../../../../core/errors/failure_types.dart';

part 'tickets_event.dart';

part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final TicketRepository repository;

  final List<Ticket> tickets = [];

  TicketsBloc({
    required this.repository,
  }) : super(GetTicketsInitial()) {
    on<GetTickets>(_onGetTicketsEvent);
    on<DeleteTicket>(_onDeleteTicketEvent);
  }

  void _onGetTicketsEvent(
    GetTickets event,
    Emitter<TicketsState> emit,
  ) async {
    emit(GetTicketsLoading());

    final result = await repository.getTickets(event.releaseId);

    result.fold(
      (failure) => emit(GetTicketsFailure(FailureType.fromFailure(failure))),
      (ticketsData) {
        tickets.clear();
        tickets.addAll(ticketsData);
        emit(GetTicketsSuccess(tickets));
      },
    );
  }

  void _onDeleteTicketEvent(
    DeleteTicket event,
    Emitter<TicketsState> emit,
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
