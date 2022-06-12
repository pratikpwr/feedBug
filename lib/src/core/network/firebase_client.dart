import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseClient {
  CollectionReference collection(String collection);
}

class FirebaseClientImpl implements FirebaseClient {
  final FirebaseFirestore firestore;

  FirebaseClientImpl(this.firestore);

  @override
  CollectionReference collection(String collection) =>
      firestore.collection(collection);
}
