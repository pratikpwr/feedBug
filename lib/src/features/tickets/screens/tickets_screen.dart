import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setuback/src/core/app/injection_container.dart';
import 'package:setuback/src/core/extension/context_extension.dart';
import 'package:setuback/src/core/views/atomic/atoms/card_item.dart';
import 'package:setuback/src/core/views/atomic/atoms/icon_item.dart';
import 'package:setuback/src/core/views/atomic/atoms/padding.dart';
import 'package:setuback/src/core/views/widgets/loader.dart';
import 'package:setuback/src/core/views/widgets/unknown_state.dart';
import 'package:setuback/src/features/tickets/bloc/create_ticket/create_ticket_cubit.dart';
import 'package:setuback/src/features/tickets/bloc/submit_ticket/submit_ticket_bloc.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';
import 'package:setuback/src/features/tickets/screens/ticket_details_screen.dart';

import '../../../core/views/widgets/failure_view.dart';
import '../bloc/get_tickets/get_tickets_bloc.dart';
import 'create_ticket_screen.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    Key? key,
    required this.releaseId,
  }) : super(key: key);

  final String releaseId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  GetTicketsBloc(repository: sl())..add(GetTickets())),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tickets'),
          ),
          floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CreateTicketScreen();
                  })).then((value) =>
                      BlocProvider.of<GetTicketsBloc>(context).add(GetTickets()));
                },
                child: const Icon(Icons.add),
              );
            }
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<GetTicketsBloc, GetTicketsState>(
              builder: (context, state) {
                if (state is GetTicketsLoading) {
                  return const Loader();
                }
                if (state is GetTicketsSuccess) {
                  return ListView.builder(
                    itemCount: state.tickets.length,
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TicketsWidget(ticket: state.tickets[index]);
                    },
                  );
                }
                if (state is GetTicketsFailure) {
                  return FailureView(
                      type: state.type,
                      onRetry: () {
                        context.read<GetTicketsBloc>().add(GetTickets());
                      });
                }
                return const UnKnownState();
              },
            ),
          ),
        ));
  }
}

class TicketsWidget extends StatelessWidget {
  final Ticket ticket;

  const TicketsWidget({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TicketDetailsScreen(ticket: ticket);
        }));
      },
      child: Row(
        children: [
          if (ticket.ticketType != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: IconItem(
                ticket.ticketType!.icon,
                size: 30,
              ),
            ),
          padding12,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket.title,
                maxLines: 2,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                ticket.description ?? '',
                maxLines: 3,
                style: context.theme.textTheme.bodyLarge,
              ),
              if (ticket.priority != null)
                Row(
                  children: [
                    Text(
                      'Priority',
                      style: context.theme.textTheme.labelLarge,
                    ),
                    padding8,
                    IconItem(
                      ticket.priority!.iconPath,
                      type: IconType.svg,
                    ),
                  ],
                ),
              Row(
                children: [
                  Text(
                    'Status',
                    style: context.theme.textTheme.labelLarge,
                  ),
                  padding8,
                  Text(
                    ticket.status.name.toUpperCase(),
                    style: context.theme.textTheme.bodyMedium,
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
