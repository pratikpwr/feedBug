import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/ticket_enums.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit() : super(const CreateTicketState());

  void title(String title) {
    final newState = state.copyWith(title: title);
    emit(newState);
  }


}
