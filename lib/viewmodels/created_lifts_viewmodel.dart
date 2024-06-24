import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/services/firestore_service.dart';

class CreatedLiftsViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  Stream<List<Lift>> getLiftsStream() {
    return _firestoreService.getLiftsStream();
  }

  Future<void> updateLift(Lift updatedLift) async {
    await _firestoreService.updateLift(updatedLift);
  }

  Future<void> deleteLift(String liftId) async {
    await _firestoreService.deleteLift(liftId);
  }
}

