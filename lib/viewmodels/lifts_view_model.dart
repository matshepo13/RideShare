import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/services/firestore_service.dart';

class LiftViewModel extends ChangeNotifier {
  List<Lift> _lifts = [];

  List<Lift> get lifts => _lifts;

  final FirestoreService _firestoreService = FirestoreService();

  LiftViewModel() {
    fetchLifts();
  }

  Future<void> fetchLifts() async {
    _lifts = await _firestoreService.getAvailableLifts();
    notifyListeners();
  }

  Future<void> updateLift(Lift updatedLift) async {
    await _firestoreService.updateLift(updatedLift);
    await fetchLifts();
  }
}
