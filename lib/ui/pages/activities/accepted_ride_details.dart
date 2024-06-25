
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/ui/components/gradient_button.dart';
import 'package:lifts_app/viewmodels/notification_viewmodel.dart';
import 'package:lifts_app/model/notification_model.dart' as custom;

class AcceptedRideDetailPage extends StatelessWidget {
final Lift lift;
final DateTime acceptedTimestamp;

AcceptedRideDetailPage({required this.lift, required this.acceptedTimestamp});

@override
Widget build(BuildContext context) {
double amountPerSeat = double.tryParse(lift.amountPerSeat) ?? 0.0;
DateTime destinationTime = acceptedTimestamp.add(Duration(hours: 3));

return Scaffold(
appBar: AppBar(
backgroundColor: const Color(0xFF15203C),
centerTitle: true,
iconTheme: IconThemeData(
color: Colors.white, // Change back button color to white
),
title: Text(
'Accepted Ride Details',
style: TextStyle(color: Colors.white),
),
),
backgroundColor: const Color(0xFF15203C),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
width: double.infinity,
// child: Image.asset(
// 'assets/image.png',
// fit: BoxFit.cover,
// ),
),
SizedBox(height: 20.0), // Space below map
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
"Jacob Jones",
style: TextStyle(fontSize: 18.0, color: Colors.white),
),
Row(
children: List.generate(5, (index) {
return Icon(
Icons.star,
color: Colors.yellow,
size: 16.0,
);
}),
),
],
),
],
),
SizedBox(height: 20.0), // Space between driver details and next section
Text(
"Driver arriving in 3 minutes",
style: TextStyle(fontSize: 16.0, color: Colors.white),
),
SizedBox(height: 8.0), // Space below "arriving" text
Text(
"Car: VW Polo - White, JGK 123 GP",
style: TextStyle(fontSize: 16.0, color: Colors.white),
),
SizedBox(height: 20.0), // Space below car information
Divider(height: 1.0, color: Colors.white), // Divider between destinations
SizedBox(height: 20.0), // Space between destinations
Row(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'${lift.departureStreet}, ${lift.departureTown}',
style: TextStyle(fontSize: 18.0, color: Colors.white),
),
SizedBox(height: 20.0), // Increased space between departure and destination
Text(
'${lift.destinationStreet}, ${lift.destinationTown}',
style: TextStyle(fontSize: 18.0, color: Colors.white),
),
],
),
Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Text(
"${acceptedTimestamp.toLocal().toString().split(' ')[1].substring(0, 5)}",
style: TextStyle(fontSize: 16.0, color: Colors.white),
),
SizedBox(height: 20.0), // Increased space between times
Text(
"${destinationTime.toLocal().toString().split(' ')[1].substring(0, 5)}",
style: TextStyle(fontSize: 16.0, color: Colors.white),
),
],
),
],
),
SizedBox(height: 40.0), // Increased space below destinations
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
"Seats: ${lift.numberOfSeats}",
style: TextStyle(fontSize: 16.0, color: Colors.white),
),
Text(
"Cost: R${amountPerSeat.toStringAsFixed(2)}",
style: TextStyle(fontSize: 16.0, color: Colors.white),
),
],
),
SizedBox(height: 40.0), // Increased space below cost
Center(
child: GradientButton(
onPressed: () {
// Add notification when the ride is cancelled
Provider.of<NotificationViewModel>(context, listen: false).addNotification(
custom.Notification(
title: "Ride Cancelled",
message: "You have cancelled your ride from ${lift.departureTown} to ${lift.destinationTown}.",
timestamp: DateTime.now(),
type: "cancelled",
lift: lift,
),
);
Navigator.pop(context); // Go back to the previous page
},
text: "Cancel Ride",
),
),
],
),
),
);
}
}


