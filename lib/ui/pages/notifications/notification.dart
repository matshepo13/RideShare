import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/ui/components/navbar.dart';
import 'package:lifts_app/model/notification_model.dart' as custom;
import 'package:lifts_app/viewmodels/notification_viewmodel.dart';
import 'package:lifts_app/ui/pages/activities/accepted_ride_details.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications =
        Provider.of<NotificationViewModel>(context).notifications;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF15203C),
        title: const Center(
            child: Text('Notifications', style: TextStyle(color: Colors.white))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle bottom nav bar tap if necessary
        },
      ),
      body: Container(
        color: const Color(0xFF15203C),
        child: notifications.isEmpty
            ? const Center(
            child: Text('No notifications',
                style: TextStyle(color: Colors.white)))
            : ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            IconData iconData;
            Color iconColor;

            switch (notification.type) {
              case 'accepted':
                iconData = Icons.sentiment_satisfied_alt;
                iconColor = Colors.green;
                break;
              case 'reminder':
                iconData = Icons.notifications;
                iconColor = Colors.blue;
                break;
              case 'deleted':
                iconData = Icons.delete;
                iconColor = Colors.red;
                break;
              case 'updated':
                iconData = Icons.edit;
                iconColor = Colors.orange;
                break;
              default:
                iconData = Icons.message;
                iconColor = Colors.grey;
            }

            return Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2A47),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.transparent,
                  width: 3,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: gradientIcon(
                        iconData, [const Color(0xFF44B3DF), Colors.purple]),
                    title: Text(
                      notification.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      notification.message,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      '${notification.timestamp.hour}:${notification.timestamp.minute}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      if (notification.type == 'accepted')
                        TextButton(
                          onPressed: () {
                            if (notification.lift != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AcceptedRideDetailPage(
                                    lift: notification.lift!,
                                    acceptedTimestamp: DateTime.now(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('View Ride Details',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      if (notification.type == 'reminder')
                        TextButton(
                          onPressed: () {
                            // Handle reminder button action
                          },
                          child: const Text('View Reminder',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      if (notification.type == 'updated')
                        TextButton(
                          onPressed: () {
                            if (notification.lift != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AcceptedRideDetailPage(
                                    lift: notification.lift!,
                                    acceptedTimestamp: DateTime.now(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Review New Details',
                              style: TextStyle(color: Colors.blue)),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget gradientIcon(IconData iconData, List<Color> gradientColors) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
