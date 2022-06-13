import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/ticket_enums.dart';
import '../../models/ticket_model.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit() : super(const CreateTicketState());

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final improvementController = TextEditingController();
  final occurrenceModelController = TextEditingController();
  final occurrenceElementController = TextEditingController();
  final deviceNameController = TextEditingController();
  final deviceModelController = TextEditingController();

  void title(String title) {
    emit(state.copyWith(title: title));
  }

  void description(String description) {
    emit(state.copyWith(description: description));
  }

  void priority(TicketPriority priority) {
    emit(state.copyWith(priority: priority));
  }

  void ticketType(TicketType ticketType) {
    emit(state.copyWith(ticketType: ticketType));
  }

  void improvement(String improvement) {
    emit(state.copyWith(improvement: improvement));
  }

  void occurrenceModel(String occurrenceModel) {
    emit(state.copyWith(occurrenceModule: occurrenceModel));
  }

  void occurrenceElement(String occurrenceElement) {
    emit(state.copyWith(occurrenceElement: occurrenceElement));
  }

  void deviceName(String deviceName) {
    emit(state.copyWith(deviceName: deviceName));
  }

  void deviceModel(String deviceModel) {
    emit(state.copyWith(deviceModel: deviceModel));
  }

  Ticket createTicket() {
    return Ticket(
      id: '',
      title: state.title ?? '',
      projectId: 'CqxKPtYot8X473GN0iND',
      releaseId: 'je4YaTHr5lmURRqYtClw',
      status: TicketStatus.created,
      createdBy: 'AjFUaO5SKHz8O7uKaAuG',
      description: state.description,
      priority: state.priority,
      ticketType: state.ticketType,
      improvement: state.improvement,
      occurrenceModule: state.occurrenceModule,
      occurrenceElement: state.occurrenceElement,
      device: state.deviceName,
      deviceModel: state.deviceModel,
    );
  }
}
