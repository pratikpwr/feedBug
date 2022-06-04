import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/app/injection_container.dart';
import 'package:setuback/src/core/views/atomic/atoms/icon_item.dart';
import 'package:setuback/src/core/views/widgets/loader.dart';
import 'package:setuback/src/core/views/widgets/unknown_state.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';

import '../../../core/views/widgets/failure_view.dart';
import '../bloc/get_tickets/get_tickets_bloc.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    Key? key,
    required this.releaseId,
  }) : super(key: key);

  final String releaseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            GetTicketsBloc(repository: sl())..add(GetTickets()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tickets'),
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<GetTicketsBloc, GetTicketsState>(
              builder: (context, state) {
                if (state is GetTicketsLoading) {
                  return const Loader();
                }
                if (state is GetTicketsSuccess) {
                  return TicketsWidget(tickets: state.tickets);
                }
                if (state is GetTicketsFailure) {
                  return FailureView(type: state.type);
                }
                return const UnKnownState();
              },
            ),
          ),
        ));
  }
}

class TicketsWidget extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketsWidget({Key? key, required this.tickets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tickets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return ListTile(
            leading: ticket.ticketType != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: IconItem(
                      ticket.ticketType!.icon,
                      size: 30,
                    ),
                  )
                : const SizedBox(),
            title: Text(ticket.title),
            subtitle: Text(ticket.description ?? ''),
          );
        });
  }
}
