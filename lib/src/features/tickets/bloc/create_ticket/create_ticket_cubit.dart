import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/ticket_enums.dart';
import '../../models/ticket_model.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit() : super(CreateTicketState());

  void title(String title) {
    final newState = state.copyWith(title: title);
    emit(newState);
  }

  void description(String description) {
    final newState = state.copyWith(description: description);
    emit(newState);
  }

  void priority(TicketPriority priority) {
    final newState = state.copyWith(priority: priority);
    emit(newState);
  }

  void ticketType(TicketType ticketType) {
    final newState = state.copyWith(ticketType: ticketType);
    emit(newState);
  }

  void improvement(String improvement) {
    final newState = state.copyWith(improvement: improvement);
    emit(newState);
  }

  void occurrenceModel(String occurrenceModel) {
    final newState = state.copyWith(occurrenceModel: occurrenceModel);
    emit(newState);
  }

  void occurrenceElement(String occurrenceElement) {
    final newState = state.copyWith(occurrenceElement: occurrenceElement);
    emit(newState);
  }

  void deviceName(String deviceName) {
    final newState = state.copyWith(deviceName: deviceName);
    emit(newState);
  }

  void deviceModel(String deviceModel) {
    final newState = state.copyWith(deviceModel: deviceModel);
    emit(newState);
  }

  Ticket createTicket() {
    return Ticket(
      id: '',
      title: state.titleController.text,
      projectId: 'CqxKPtYot8X473GN0iND',
      status: TicketStatus.created,
      createdBy: 'AjFUaO5SKHz8O7uKaAuG',
      description: state.descriptionController.text,
      priority: state.priority,
      ticketType: state.ticketType,
      improvement: state.improvementController.text,
      occurrenceModule: state.occurrenceModelController.text,
      occurrenceElement: state.occurrenceElementController.text,
      device: state.deviceNameController.text,
      deviceModel: state.deviceModelController.text,
    );
  }
}
