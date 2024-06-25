// Defines a Booking model with user ID, lift ID, and confirmation status, and a FirestoreService class
// for managing booking data in Cloud Firestore by creating new booking documents.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Booking {
  final String userId;
  final String liftId;
  final bool confirmed;

  Booking({
    required this.userId,
    required this.liftId,
    required this.confirmed,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'liftId': liftId,
      'confirmed': confirmed,
    };
  }

  static Booking fromMap(Map<String, dynamic> map) {
    return Booking(
      userId: map['userId'],
      liftId: map['liftId'],
      confirmed: map['confirmed'],
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createBooking(Booking booking) async {
    await _db.collection('bookings').add(booking.toMap());
  }
}
