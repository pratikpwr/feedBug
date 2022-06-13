import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';
import 'package:setuback/src/features/tickets/repository/ticket_repository.dart';

import '../../../../core/errors/failure_types.dart';

part 'get_tickets_event.dart';

part 'get_tickets_state.dart';

class GetTicketsBloc extends Bloc<GetTicketsEvent, GetTicketsState> {
  final TicketRepository repository;

  GetTicketsBloc({
    required this.repository,
  }) : super(GetTicketsInitial()) {
    on<GetTickets>(_onGetTicketsEvent);
  }

  void _onGetTicketsEvent(
    GetTickets event,
    Emitter<GetTicketsState> emit,
  ) async {
    emit(GetTicketsLoading());

    final result = await repository.getTickets(event.releaseId);

    result.fold(
      (failure) => emit(GetTicketsFailure(FailureType.fromFailure(failure))),
      (tickets) => emit(GetTicketsSuccess(tickets)),
    );
  }
}
