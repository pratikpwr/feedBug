part of 'create_update_ticket_bloc.dart';

abstract class CreateUpdateTicketState extends Equatable {
  const CreateUpdateTicketState();
}

class SubmitTicketInitial extends CreateUpdateTicketState {
  @override
  List<Object> get props => [];
}

class SubmitTicketLoading extends CreateUpdateTicketState {
  @override
  List<Object> get props => [];
}

class SubmitTicketSuccess extends CreateUpdateTicketState {
  @override
  List<Object> get props => [];
}

class SubmitTicketFailure extends CreateUpdateTicketState {
  final FailureType type;

  const SubmitTicketFailure(this.type);

  @override
  List<Object> get props => [type];
}
