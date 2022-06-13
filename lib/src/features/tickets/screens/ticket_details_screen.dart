import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/views/atomic/atoms/padding.dart';
import '../models/ticket_model.dart';

class TicketDetailsScreen extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailsScreen({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.title,
              style: context.theme.textTheme.titleLarge,
              maxLines: 3,
            ),
            padding8,
            Text(
              ticket.description ?? '',
              style: context.theme.textTheme.bodyLarge,
              maxLines: 8,
            ),
          ],
        ),
      ),
    );
  }
}
