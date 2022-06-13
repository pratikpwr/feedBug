import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/views/atomic/atoms/card_item.dart';
import '../../../core/views/atomic/atoms/icon_item.dart';
import '../../../core/views/atomic/atoms/padding.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../../releases/models/release_model.dart';
import '../bloc/tickets_bloc/tickets_bloc.dart';
import '../models/ticket_model.dart';
import 'create_ticket_screen.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    Key? key,
    required this.release,
  }) : super(key: key);

  final Release release;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => TicketsBloc(repository: sl())
                ..add(GetTickets(releaseId: release.id))),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tickets'),
          ),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateTicketScreen(
                    release: release,
                  );
                })).then((value) => BlocProvider.of<TicketsBloc>(context)
                    .add(GetTickets(releaseId: release.id)));
              },
              child: const Icon(Icons.add),
            );
          }),
          body: SingleChildScrollView(
            child: BlocBuilder<TicketsBloc, TicketsState>(
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
                      return Dismissible(
                        key: Key(state.tickets[index].id.toString()),
                        background: Container(
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.red[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              padding8,
                              Icon(Icons.delete),
                            ],
                          ),
                        ),
                        onDismissed: (direction) => _onDismissed(
                          context,
                          direction,
                          state.tickets[index],
                        ),
                        confirmDismiss: (direction) => _confirmDismiss(
                          context,
                          direction,
                          state.tickets[index],
                        ),
                        child: TicketsWidget(
                          ticket: state.tickets[index],
                          release: release,
                        ),
                      );
                    },
                  );
                }
                if (state is GetTicketsFailure) {
                  return FailureView(
                      type: state.type,
                      onRetry: () {
                        context
                            .read<TicketsBloc>()
                            .add(GetTickets(releaseId: release.id));
                      });
                }
                return const UnKnownState();
              },
            ),
          ),
        ));
  }

  void _onDismissed(
      BuildContext context, DismissDirection direction, Ticket ticket) {
    if (direction == DismissDirection.endToStart) {
      BlocProvider.of<TicketsBloc>(context)
          .add(DeleteTicket(ticketId: ticket.id));
    }
  }

  Future<bool?> _confirmDismiss(
      BuildContext context, DismissDirection direction, Ticket ticket) async {
    if (direction == DismissDirection.endToStart) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete ticket'),
          content: const Text('Are you sure you want to delete this ticket?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );
    }
    return null;
  }
}

class TicketsWidget extends StatelessWidget {
  final Ticket ticket;
  final Release release;

  const TicketsWidget({
    Key? key,
    required this.ticket,
    required this.release,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      onTap: () => _editTicket(context),
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
          )),
        ],
      ),
    );
  }

  void _editTicket(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateTicketScreen(
        ticket: ticket,
        release: release,
      );
    })).then((value) => BlocProvider.of<TicketsBloc>(context)
        .add(GetTickets(releaseId: release.id)));
  }
}
