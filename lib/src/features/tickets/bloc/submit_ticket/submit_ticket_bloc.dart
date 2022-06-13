import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:setuback/src/core/errors/failure_types.dart';

import '../../models/ticket_model.dart';
import '../../repository/ticket_repository.dart';

part 'submit_ticket_event.dart';
part 'submit_ticket_state.dart';

class SubmitTicketBloc extends Bloc<SubmitTicketEvent, SubmitTicketState> {
  SubmitTicketBloc({required this.repository,}) : super(SubmitTicketInitial()) {
    on<SubmitTicket>(_submitTicketEvent);
    on<UpdateTicket>(_updateTicketEvent);
  }

  final TicketRepository repository;

  _submitTicketEvent(SubmitTicket event, Emitter<SubmitTicketState> emit) async {
    emit(SubmitTicketLoading());

    final result = await repository.submitTicket(event.ticket);

    result.fold(
      (failure) => emit(SubmitTicketFailure(FailureType.fromFailure(failure))),
      (ticket) => emit(SubmitTicketSuccess()),
    );
  }
  _updateTicketEvent(UpdateTicket event, Emitter<SubmitTicketState> emit) async {
    emit(SubmitTicketLoading());

    final result = await repository.updateTicket(event.ticket);

    result.fold(
      (failure) => emit(SubmitTicketFailure(FailureType.fromFailure(failure))),
      (ticket) => emit(SubmitTicketSuccess()),
    );
  }
}
