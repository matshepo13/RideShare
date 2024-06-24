import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/ui/components/navbar.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/viewmodels/created_lifts_viewmodel.dart';
import 'package:lifts_app/viewmodels/notification_viewmodel.dart';
import 'package:lifts_app/model/notification_model.dart' as custom;

class EditLiftPage extends StatefulWidget {
  final Lift lift;

  EditLiftPage({required this.lift});

  @override
  _EditLiftPageState createState() => _EditLiftPageState();
}

class _EditLiftPageState extends State<EditLiftPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _departureStreetController;
  late TextEditingController _departureTownController;
  late TextEditingController _destinationStreetController;
  late TextEditingController _destinationTownController;
  late TextEditingController _numberOfSeatsController;
  late TextEditingController _amountPerSeatController;
  late DateTime _departureDateTime;

  @override
  void initState() {
    super.initState();
    _departureStreetController = TextEditingController(text: widget.lift.departureStreet);
    _departureTownController = TextEditingController(text: widget.lift.departureTown);
    _destinationStreetController = TextEditingController(text: widget.lift.destinationStreet);
    _destinationTownController = TextEditingController(text: widget.lift.destinationTown);
    _numberOfSeatsController = TextEditingController(text: widget.lift.numberOfSeats.toString());
    _amountPerSeatController = TextEditingController(text: widget.lift.amountPerSeat);
    _departureDateTime = widget.lift.departureDateTime; // Initialize here
  }

  @override
  void dispose() {
    _departureStreetController.dispose();
    _departureTownController.dispose();
    _destinationStreetController.dispose();
    _destinationTownController.dispose();
    _numberOfSeatsController.dispose();
    _amountPerSeatController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _departureDateTime,
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_departureDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _departureDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF15203C),
        title: const Center(
          child: Text('Edit Lift', style: TextStyle(color: Colors.white)),
        ),
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _departureStreetController,
                decoration: InputDecoration(
                  labelText: 'Departure Street',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a departure street';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _departureTownController,
                decoration: InputDecoration(
                  labelText: 'Departure Town',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a departure town';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinationStreetController,
                decoration: InputDecoration(
                  labelText: 'Destination Street',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination street';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinationTownController,
                decoration: InputDecoration(
                  labelText: 'Destination Town',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination town';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberOfSeatsController,
                decoration: InputDecoration(
                  labelText: 'Number of Seats',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of seats';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountPerSeatController,
                decoration: InputDecoration(
                  labelText: 'Amount per Seat',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount per seat';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  "Departure Date & Time: ${_departureDateTime.toLocal()}".split(' ')[0] + " ${_departureDateTime.toLocal().hour}:${_departureDateTime.toLocal().minute}",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                onTap: () => _selectDateTime(context),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Lift updatedLift = Lift(
                          id: widget.lift.id,
                          departureStreet: _departureStreetController.text,
                          departureTown: _departureTownController.text,
                          departureDateTime: _departureDateTime,
                          destinationStreet: _destinationStreetController.text,
                          destinationTown: _destinationTownController.text,
                          numberOfSeats: int.parse(_numberOfSeatsController.text),
                          amountPerSeat: _amountPerSeatController.text,
                          profileVerified: widget.lift.profileVerified,
                          sameGender: widget.lift.sameGender,
                          isCardSelected: widget.lift.isCardSelected,
                        );
                        await Provider.of<CreatedLiftsViewModel>(context, listen: false).updateLift(updatedLift);
                        Provider.of<NotificationViewModel>(context, listen: false).addNotification(
                          custom.Notification(
                            title: "Ride Details Updated",
                            message: "The driver has changed the ride details.",
                            timestamp: DateTime.now(),
                            type: "updated",
                            lift: updatedLift,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.lift.id != null) {
                        await Provider.of<CreatedLiftsViewModel>(context, listen: false).deleteLift(widget.lift.id!);
                        Provider.of<NotificationViewModel>(context, listen: false).addNotification(
                          custom.Notification(
                            title: "Ride Deleted",
                            message: "The driver has deleted the ride from ${widget.lift.departureTown} to ${widget.lift.destinationTown}.",
                            timestamp: DateTime.now(),
                            type: "deleted",
                            lift: widget.lift,
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        // Handle case where lift ID is null (if necessary)
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


