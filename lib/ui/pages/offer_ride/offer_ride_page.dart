import 'package:flutter/material.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/services/firestore_service.dart';
import 'package:lifts_app/ui/components/gradient_button.dart'; // Ensure this path is correct
import 'package:lifts_app/ui/components/navbar.dart'; // Ensure this path is correct
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RideShare extends StatefulWidget {
  @override
  _RideShareState createState() => _RideShareState();
}

class _RideShareState extends State<RideShare> {
  int _currentIndex = 0;
  int numberOfSeats = 1;
  bool profileVerified = false;
  bool sameGender = false;
  bool isCardSelected = false;
  bool isPaymentSelected = false;
  DateTime? selectedDate;
  String? selectedTime;
  String? amountPerSeat;
  String departureStreet = '';
  String departureTown = '';
  String destinationStreet = '';
  String destinationTown = '';

  List<String> generateTimes() {
    List<String> times = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 60) {
        times.add('${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}');
      }
    }
    return times;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2024, 12, 31),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RideShare()),
      );
    }
  }

  void _createLift() {
    if (selectedDate != null && selectedTime != null && amountPerSeat != null) {
      DateTime departureDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        int.parse(selectedTime!.split(':')[0]),
        int.parse(selectedTime!.split(':')[1]),
      );

      String? userId = FirebaseAuth.instance.currentUser?.uid;

      Lift lift = Lift(
        departureStreet: departureStreet,
        departureTown: departureTown,
        departureDateTime: departureDateTime,
        destinationStreet: destinationStreet,
        destinationTown: destinationTown,
        numberOfSeats: numberOfSeats,
        profileVerified: profileVerified,
        sameGender: sameGender,
        isCardSelected: isCardSelected,
        amountPerSeat: amountPerSeat!,
        userId: userId,  // Include userId here
      );

      FirebaseFirestore.instance.collection('lifts').add(lift.toMap()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lift created successfully!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create lift: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15203C),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: PageController(initialPage: 0),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  // Find Ride Page
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Departure Street',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              departureStreet = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Departure Town',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              departureTown = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => _selectDate(context),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Date',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    child: Text(
                                      selectedDate != null
                                          ? "${selectedDate!.toLocal()}".split(' ')[0]
                                          : 'Select Date',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Time',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  dropdownColor: Color(0xFF15203C),
                                  style: TextStyle(color: Colors.white),
                                  value: selectedTime,
                                  items: generateTimes().map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedTime = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Destination Street',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              destinationStreet = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Destination Town',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              destinationTown = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Number of seats',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (numberOfSeats > 1) numberOfSeats--;
                                      });
                                    },
                                    icon: Icon(Icons.remove, color: Colors.white),
                                  ),
                                  Text('$numberOfSeats', style: TextStyle(fontSize: 16, color: Colors.white)),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (numberOfSeats < 5) numberOfSeats++;
                                      });
                                    },
                                    icon: Icon(Icons.add, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Add a note',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Passenger Preferences',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Only profile verified users',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    Switch(
                                      value: profileVerified,
                                      onChanged: (bool value) {
                                        setState(() {
                                          profileVerified = value;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Same gender passangers',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    Switch(
                                      value: sameGender,
                                      onChanged: (bool value) {
                                        setState(() {
                                          sameGender = value;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Payment Method',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Card',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    Radio(
                                      value: true,
                                      groupValue: isCardSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isCardSelected = value!;
                                          isPaymentSelected = true;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                    Text(
                                      'Cash',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    Radio(
                                      value: false,
                                      groupValue: isCardSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isCardSelected = value!;
                                          isPaymentSelected = true;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ],
                                ),
                                if (isPaymentSelected)
                                  SizedBox(height: 16),
                                if (isPaymentSelected)
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Amount per seat',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (value) {
                                      setState(() {
                                        amountPerSeat = value;
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          GradientButton(
                            onPressed: _createLift,
                            text: 'Create Lift',
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Offer Ride Page
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Your Offer Ride form goes here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
