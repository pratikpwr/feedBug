import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/ticket_model.dart';
import '../../repository/ticket_repository.dart';

part 'create_update_ticket_event.dart';

part 'create_update_ticket_state.dart';

class CreateUpdateTicketBloc
    extends Bloc<CreateUpdateTicketEvent, CreateUpdateTicketState> {
  CreateUpdateTicketBloc({
    required this.repository,
  }) : super(SubmitTicketInitial()) {
    on<SubmitTicket>(_submitTicketEvent);
    on<UpdateTicket>(_updateTicketEvent);
  }

  final TicketRepository repository;

  _submitTicketEvent(
      SubmitTicket event, Emitter<CreateUpdateTicketState> emit) async {
    emit(SubmitTicketLoading());

    final result = await repository.submitTicket(event.ticket);

    result.fold(
      (failure) => emit(SubmitTicketFailure(FailureType.fromFailure(failure))),
      (ticket) => emit(SubmitTicketSuccess()),
    );
  }

  _updateTicketEvent(
      UpdateTicket event, Emitter<CreateUpdateTicketState> emit) async {
    emit(SubmitTicketLoading());

    final result = await repository.updateTicket(event.ticket);

    result.fold(
      (failure) => emit(SubmitTicketFailure(FailureType.fromFailure(failure))),
      (ticket) => emit(SubmitTicketSuccess()),
    );
  }
}
