//provides a structured way to represent and work with lift offers
import 'package:cloud_firestore/cloud_firestore.dart';

class Lift {
  final String? id;
  final String departureStreet;
  final String departureTown;
  final DateTime departureDateTime;
  final String destinationStreet;
  final String destinationTown;
  final int numberOfSeats;
  final bool profileVerified;
  final bool sameGender;
  final bool isCardSelected;
  final String amountPerSeat;
  final String? userId;

  Lift({
    this.id,
    required this.departureStreet,
    required this.departureTown,
    required this.departureDateTime,
    required this.destinationStreet,
    required this.destinationTown,
    required this.numberOfSeats,
    required this.profileVerified,
    required this.sameGender,
    required this.isCardSelected,
    required this.amountPerSeat,
    this.userId,
  });

  factory Lift.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Lift(
      id: doc.id,
      departureStreet: data['departureStreet'],
      departureTown: data['departureTown'],
      departureDateTime: (data['departureDateTime'] as Timestamp).toDate(),
      destinationStreet: data['destinationStreet'],
      destinationTown: data['destinationTown'],
      numberOfSeats: data['numberOfSeats'],
      profileVerified: data['profileVerified'],
      sameGender: data['sameGender'],
      isCardSelected: data['isCardSelected'],
      amountPerSeat: data['amountPerSeat'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departureStreet': departureStreet,
      'departureTown': departureTown,
      'departureDateTime': departureDateTime,
      'destinationStreet': destinationStreet,
      'destinationTown': destinationTown,
      'numberOfSeats': numberOfSeats,
      'profileVerified': profileVerified,
      'sameGender': sameGender,
      'isCardSelected': isCardSelected,
      'amountPerSeat': amountPerSeat,
      'userId': userId,
    };
  }

  static Lift fromMap(String id, Map<String, dynamic> map) {
    return Lift(
      id: id,
      userId: map['userId'],
      departureStreet: map['departureStreet'],
      departureTown: map['departureTown'],
      departureDateTime: (map['departureDateTime'] as Timestamp).toDate(),
      destinationStreet: map['destinationStreet'],
      destinationTown: map['destinationTown'],
      numberOfSeats: map['numberOfSeats'],
      profileVerified: map['profileVerified'],
      sameGender: map['sameGender'],
      isCardSelected: map['isCardSelected'],
      amountPerSeat: map['amountPerSeat'],
    );
  }
}
