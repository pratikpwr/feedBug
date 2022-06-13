import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/enums/ticket_enums.dart';
import 'package:setuback/src/core/views/atomic/atoms/drop_down_item.dart';
import 'package:setuback/src/core/views/atomic/atoms/textfield_item.dart';
import 'package:setuback/src/features/releases/models/release_model.dart';
import 'package:setuback/src/features/tickets/bloc/create_ticket/create_ticket_cubit.dart';
import 'package:setuback/src/features/tickets/bloc/submit_ticket/submit_ticket_bloc.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/atomic/atoms/padding.dart';

class CreateTicketScreen extends StatelessWidget {
  final Release release;

  const CreateTicketScreen({
    Key? key,
    required this.release,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateTicketCubit(),
        ),
        BlocProvider(
          create: (context) => sl<SubmitTicketBloc>(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Ticket'),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              final ticket = BlocProvider.of<CreateTicketCubit>(context)
                  .createTicket(release);

              BlocProvider.of<SubmitTicketBloc>(context)
                  .add(SubmitTicket(ticket: ticket));
            },
            child: BlocConsumer<SubmitTicketBloc, SubmitTicketState>(
              listener: (context, state) {
                if (state is SubmitTicketSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is SubmitTicketLoading) {
                  return const CircularProgressIndicator();
                }
                return const Icon(Icons.save);
              },
            ),
          );
        }),
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
                      controller: cubit.titleController,
                      onChanged: cubit.title,
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Description*',
                      controller: cubit.descriptionController,
                      onChanged: cubit.description,
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
                      controller: cubit.improvementController,
                      onChanged: cubit.improvement,
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Occurrence Module',
                      controller: cubit.occurrenceModelController,
                      onChanged: cubit.occurrenceModel,
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Occurrence Element',
                      controller: cubit.occurrenceElementController,
                      onChanged: cubit.occurrenceElement,
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Device',
                      controller: cubit.deviceNameController,
                      onChanged: cubit.deviceName,
                    ),
                    padding16,
                    LabelledTextFieldItem(
                      title: 'Device Model',
                      controller: cubit.deviceModelController,
                      onChanged: cubit.deviceModel,
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
