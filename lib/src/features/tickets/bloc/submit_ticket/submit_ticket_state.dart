part of 'submit_ticket_bloc.dart';

abstract class SubmitTicketState extends Equatable {
  const SubmitTicketState();
}

class SubmitTicketInitial extends SubmitTicketState {
  @override
  List<Object> get props => [];
}

class SubmitTicketLoading extends SubmitTicketState {
  @override
  List<Object> get props => [];
}

class SubmitTicketSuccess extends SubmitTicketState {
  @override
  List<Object> get props => [];
}

class SubmitTicketFailure extends SubmitTicketState {
  final FailureType type;

  const SubmitTicketFailure(this.type);

  @override
  List<Object> get props => [type];
}
