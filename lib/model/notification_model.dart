import 'package:lifts_app/model/lift_model.dart';

class Notification {
  final String title;
  final String message;
  final DateTime timestamp;
  final String type;
  final Lift? lift; // Optional Lift object

  Notification({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.lift,
  });
}
