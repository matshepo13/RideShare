import 'package:flutter/foundation.dart';
import 'package:lifts_app/services/notification_service.dart';
import 'package:lifts_app/model/notification_model.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationService _notificationService;
  List<Notification> _notifications = [];

  NotificationViewModel(this._notificationService) {
    fetchNotifications();
  }

  List<Notification> get notifications => _notifications;

  Future<void> fetchNotifications() async {
    _notifications = await _notificationService.getNotifications();
    notifyListeners();
  }

  void addNotification(Notification notification) {
    _notifications.add(notification);
    notifyListeners();
  }
}
