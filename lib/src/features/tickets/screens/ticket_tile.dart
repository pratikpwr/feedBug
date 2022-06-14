import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/views/atomic/atoms/card_item.dart';
import '../../../core/views/atomic/atoms/icon_item.dart';
import '../../../core/views/atomic/atoms/padding.dart';
import '../../releases/models/release_model.dart';
import '../bloc/get_delete_ticket_bloc/get_delete_ticket_bloc.dart';
import '../models/ticket_model.dart';
import 'create_edit_ticket_screen.dart';

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
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Dismissible(
        key: Key(ticket.id),
        background: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: theme.colorScheme.onErrorContainer,
            ),
            padding16,
          ],
        ),
        onDismissed: (direction) => _onDismissed(
          context,
          direction,
        ),
        confirmDismiss: (direction) => _confirmDismiss(
          context,
          direction,
        ),
        child: CardItem(
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.zero,
          onTap: () => _editTicket(context),
          child: Row(
            children: [
              if (ticket.ticketType != null) ...[
                IconItem(
                  ticket.ticketType!.icon,
                  size: 30,
                ),
                padding8,
              ],
              padding12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.title,
                      maxLines: 2,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      ticket.description ?? '',
                      maxLines: 2,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (ticket.status != null)
                      Row(
                        children: [
                          Text(
                            'Status',
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                          ),
                          padding8,
                          Text(
                            ticket.status!.name.toUpperCase(),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      )
                  ],
                ),
              ),
              if (ticket.priority != null) ...[
                padding8,
                IconItem(
                  ticket.priority!.iconPath,
                  type: IconType.svg,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _onDismissed(BuildContext context, DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      BlocProvider.of<GetDeleteTicketBloc>(context)
          .add(DeleteTicket(ticketId: ticket.id));
    }
  }

  Future<bool?> _confirmDismiss(
      BuildContext context, DismissDirection direction) async {
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

  void _editTicket(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateEditTicketScreen(
        ticket: ticket,
        release: release,
      );
    })).then((value) => BlocProvider.of<GetDeleteTicketBloc>(context)
        .add(GetTickets(releaseId: release.id)));
  }
}
