import 'package:flutter/material.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/ui/components/gradient_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lifts_app/model/notification_model.dart' as custom;
import 'package:provider/provider.dart';
import 'package:lifts_app/viewmodels/notification_viewmodel.dart';
import 'package:lifts_app/ui/pages/find_ride/accepted_ride_details.dart'; // Import the AcceptedRideDetailPage

class RideDetailDialog extends StatelessWidget {
  final Lift lift;
  final VoidCallback onDecline;

  RideDetailDialog({required this.lift, required this.onDecline});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: const Color(0xFF15203C),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${lift.departureDateTime.toLocal().toString().split(' ')[0]}", // Display the date
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Text(
                    'R${lift.amountPerSeat}', // Display the price with single "R"
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/driver.jpg'),
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jacob Jones", // Placeholder name
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20.0,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            "Verified Driver",
                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.white, height: 30.0),
              Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.white, size: 24.0),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      '${lift.departureStreet}, ${lift.departureTown}', // Display departure street and town
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0), // Add space between departure and destination
              Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.purple, size: 24.0), // Changed to purple
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      '${lift.destinationStreet}, ${lift.destinationTown}', // Display destination street and town
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Departure Time: ${lift.departureDateTime.toLocal().toString().split(' ')[1].substring(0, 5)}", // Display the time only
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  Text(
                    "Seats: ${lift.numberOfSeats}",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GradientButton(
                      onPressed: () {
                        // Handle decline action
                        Navigator.pop(context);
                        onDecline();
                      },
                      text: "Decline",
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: GradientButton(
                      onPressed: () {
                        // Handle accept action
                        _playPingSound();
                        Provider.of<NotificationViewModel>(context, listen: false).addNotification(
                          custom.Notification(
                            title: 'Joining A Ride As A Passenger',
                            message: 'Monitor your ride here',
                            timestamp: DateTime.now(),
                            type: 'accepted',
                          ),
                        );
                        Navigator.pop(context); // Close the dialog after accepting
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcceptedRideDetailPage(
                              lift: lift,
                              acceptedTimestamp: DateTime.now(), // Pass the accepted timestamp
                            ),
                          ),
                        );
                      },
                      text: "Accept",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _playPingSound() async {
    final player = AudioCache();
    await player.play('ping.mp3');
  }
}

void showRideDetailDialog(BuildContext context, Lift lift, VoidCallback onDecline) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 0.75,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: RideDetailDialog(lift: lift, onDecline: onDecline),
          );
        },
      );
    },
  );
}
