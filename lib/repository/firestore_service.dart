import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _countries =
      FirebaseFirestore.instance.collection('countries');

  Future<void> saveCountry(String countryName) {
    return _countries.add({'name': countryName});
  }
}
