// FirestoreService manages interactions with Firestore, including fetching and manipulating data
// for lifts and bookings, and provides methods for creating, updating, and deleting lift and booking records.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/model/booking.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Lift>> getLiftsStream() {
    return _db.collection('lifts').snapshots().map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return Lift.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<List<Lift>> getAvailableLifts() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('lifts').get();
      List<Lift> lifts = querySnapshot.docs.map((doc) => Lift.fromSnapshot(doc)).toList();
      return lifts;
    } catch (e) {
      print("Error fetching available lifts: $e");
      return []; // Return an empty list in case of an error
    }
  }

  Future<void> createLift({
    required String departureStreet,
    required String departureTown,
    required DateTime departureDateTime,
    required String destinationStreet,
    required String destinationTown,
    required int numberPassengers,
    required String costShareDescription,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated");
    }

    await _db.collection('lifts').add({
      'departureStreet': departureStreet,
      'departureTown': departureTown,
      'departureDateTime': departureDateTime,
      'destinationStreet': destinationStreet,
      'destinationTown': destinationTown,
      'numberPassengers': numberPassengers,
      'costShareDescription': costShareDescription,
      'userId': user.uid,
    });
  }

  Future<void> updateLift(Lift lift) async {
    await _db.collection('lifts').doc(lift.id).update(lift.toMap());
  }

  Future<void> deleteLift(String liftId) async {
    await _db.collection('lifts').doc(liftId).delete();
  }

  Future<void> createBooking(Booking booking) async {
    await _db.collection('bookings').add(booking.toMap());
  }
}
