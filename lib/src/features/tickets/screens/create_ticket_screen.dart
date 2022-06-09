import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/enums/ticket_enums.dart';
import 'package:setuback/src/core/views/atomic/atoms/drop_down_item.dart';
import 'package:setuback/src/core/views/atomic/atoms/textfield_item.dart';
import 'package:setuback/src/features/tickets/bloc/create_ticket/create_ticket_cubit.dart';

import '../../../core/views/atomic/atoms/padding.dart';

class CreateTicketScreen extends StatelessWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTicketCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Ticket'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save),
        ),
        body: BlocBuilder<CreateTicketCubit, CreateTicketState>(
          builder: (context, state) {
            final cubit = context.read<CreateTicketCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    LabelledTextFieldItem(
                      title: 'Title*',
                      controller: state.titleController,
                      onChanged: (value) => cubit.title(value),
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Description*',
                      controller: state.descriptionController,
                      onChanged: (value) => cubit.description(value),
                    ),
                    padding16,
                    DropdownItem<TicketType>(
                      hint: 'Ticket Type*',
                      items: TicketType.values,
                      value: cubit.state.ticketType,
                      onChanged: (value) {
                        if (value != null) {
                          cubit.ticketType(value);
                        }
                      },
                      itemToString: (type) {
                        return type.name;
                      },
                    ),
                    padding16,
                    DropdownItem<TicketPriority>(
                      hint: 'Ticket Priority',
                      items: TicketPriority.values,
                      value: cubit.state.priority,
                      onChanged: (value) {
                        if (value != null) {
                          cubit.priority(value);
                        }
                      },
                      itemToString: (type) {
                        return type.name;
                      },
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Improvement / Expected',
                      controller: state.improvementController,
                      onChanged: (value) => cubit.improvement(value),
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Occurrence Module',
                      controller: state.occurrenceModelController,
                      onChanged: (value) => cubit.occurrenceModel(value),
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Occurrence Element',
                      controller: state.occurrenceElementController,
                      onChanged: (value) => cubit.occurrenceElement(value),
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Device',
                      controller: state.deviceNameController,
                      onChanged: (value) => cubit.deviceName(value),
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Device Model',
                      controller: state.deviceModelController,
                      onChanged: (value) => cubit.deviceModel(value),
                    ),
                    padding16,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
