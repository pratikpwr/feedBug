import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/injection_container.dart';
import '../../../core/views/widgets/failure_view.dart';
import '../../../core/views/widgets/loader.dart';
import '../../../core/views/widgets/unknown_state.dart';
import '../../releases/models/release_model.dart';
import '../bloc/tickets_bloc/tickets_bloc.dart';
import 'create_edit_ticket_screen.dart';
import 'ticket_tile.dart';

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
                  return CreateEditTicketScreen(
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
                      return TicketsWidget(
                        ticket: state.tickets[index],
                        release: release,
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
}
