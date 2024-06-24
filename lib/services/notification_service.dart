import 'package:lifts_app/model/notification_model.dart';

class NotificationService {
  Future<List<Notification>> getNotifications() async {
    // Simulate fetching data from an API or database
    await Future.delayed(Duration(seconds: 2));

    return [
      Notification(
        title: 'Ride Request',
        message: 'You have a new ride request',
        timestamp: DateTime.now(),
        type: 'request',
      ),
      Notification(
        title: 'Ride Accepted',
        message: 'Your ride has been accepted',
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
        type: 'accepted',
      ),
    ];
  }
}
