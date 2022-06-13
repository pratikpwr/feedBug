import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/ticket_enums.dart';
import '../../../releases/models/release_model.dart';
import '../../models/ticket_model.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit({
    this.ticket,
  }) : super(const CreateTicketState()) {
    _populateTicket(ticket);
  }

  final Ticket? ticket;

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

  void _populateTicket(Ticket? ticket) {
    if (ticket != null) {
      final newState = state.copyWith(
        title: ticket.title,
        description: ticket.description,
        priority: ticket.priority,
        ticketType: ticket.ticketType,
        improvement: ticket.improvement,
        occurrenceModule: ticket.occurrenceModule,
        occurrenceElement: ticket.occurrenceElement,
        deviceName: ticket.device,
        deviceModel: ticket.deviceModel,
      );

      titleController.text = ticket.title;
      descriptionController.text = ticket.description ?? '';
      improvementController.text = ticket.improvement ?? '';
      occurrenceModelController.text = ticket.occurrenceModule ?? '';
      occurrenceElementController.text = ticket.occurrenceElement ?? '';
      deviceNameController.text = ticket.device ?? '';
      deviceModelController.text = ticket.deviceModel ?? '';
      emit(newState);
    }
  }

  Ticket createTicket(Release release) {
    return Ticket(
      id: ticket?.id ?? '',
      title: state.title ?? '',
      projectId: release.projectId,
      releaseId: release.id,
      createdAt: Timestamp.now(),
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
