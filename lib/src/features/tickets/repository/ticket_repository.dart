import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/firebase_client.dart';
import '../../../core/network/network_info.dart';
import '../models/ticket_model.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<Ticket>>> getTickets(String releaseId);

  Future<Either<Failure, void>> submitTicket(Ticket ticket);
}

class TicketRepositoryImpl implements TicketRepository {
  final NetworkInfo networkInfo;
  final FirebaseClient firebaseClient;

  const TicketRepositoryImpl({
    required this.networkInfo,
    required this.firebaseClient,
  });

  CollectionReference<Ticket> get ticketRef =>
      firebaseClient.collection('ticket').withConverter<Ticket>(
            fromFirestore: (snapshot, _) => Ticket.fromJson(
              snapshot.id,
              snapshot.data()!,
            ),
            toFirestore: (ticket, _) => ticket.toJson(),
          );

  @override
  Future<Either<Failure, List<Ticket>>> getTickets(String releaseId) async {
    if (await networkInfo.isConnected) {
      try {
        List<QueryDocumentSnapshot<Ticket>> result = await ticketRef
            .where(
              'release_id',
              isEqualTo: releaseId,
            )
            .orderBy('created_at', descending: true)
            .get()
            .then((snapshot) => snapshot.docs);

        final tickets = result.map((snapshot) => snapshot.data()).toList();

        if (tickets.isEmpty) {
          return const Left(NoDataFailure());
        }

        return Right(tickets);
      } catch (e) {
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, void>> submitTicket(Ticket ticket) async {
    if (await networkInfo.isConnected) {
      await ticketRef.add(ticket).onError((error, stackTrace) {
        throw (ServerFailure(error.toString()));
      });
      return const Right(VoidCallback);
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
