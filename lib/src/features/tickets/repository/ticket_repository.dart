import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:setuback/src/core/constants/api_constants.dart';
import 'package:setuback/src/core/enums/http_method.dart';
import 'package:setuback/src/core/network/api_client.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';

import '../../../core/errors/failures.dart';
import '../../../core/graphql/gql_client.dart';
import '../../../core/graphql/gql_query.dart';
import '../../../core/network/firebase_client.dart';
import '../../../core/network/network_info.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<Ticket>>> getTickets();

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
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    if (await networkInfo.isConnected) {
      try {
        List<QueryDocumentSnapshot<Ticket>> tickets =
            await ticketRef.get().then((snapshot) => snapshot.docs);

        return Right(tickets.map((snapshot) => snapshot.data()).toList());
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
        print(error);
        throw (ServerFailure(error.toString()));
      });
      return Right(VoidCallback);
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
