import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/ticket_model.dart';
import '../../repository/ticket_repository.dart';

part 'get_delete_ticket_event.dart';

part 'get_delete_ticket_state.dart';

class GetDeleteTicketBloc
    extends Bloc<GetDeleteTicketEvent, GetDeleteTicketState> {
  final TicketRepository repository;

  final List<Ticket> tickets = [];

  GetDeleteTicketBloc({
    required this.repository,
  }) : super(GetTicketsInitial()) {
    on<GetTickets>(_onGetTicketsEvent);
    on<DeleteTicket>(_onDeleteTicketEvent);
  }

  void _onGetTicketsEvent(
    GetTickets event,
    Emitter<GetDeleteTicketState> emit,
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
    Emitter<GetDeleteTicketState> emit,
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
