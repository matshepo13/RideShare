
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/viewmodels/created_lifts_viewmodel.dart';
import 'package:lifts_app/model/lift_model.dart';
import 'package:lifts_app/ui/pages/offer_ride/edit_lift_page.dart';
import 'package:lifts_app/ui/components/navbar.dart';

class CreatedLiftsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreatedLiftsViewModel>(
      create: (_) => CreatedLiftsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF15203C),
          title: const Center(
            child: Text('Created Lifts', style: TextStyle(color: Colors.white)),
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
          child: Consumer<CreatedLiftsViewModel>(
            builder: (context, viewModel, child) {
              return StreamBuilder<List<Lift>>(
                stream: viewModel.getLiftsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No lifts available', style: TextStyle(color: Colors.white)));
                  }
                  List<Lift> lifts = snapshot.data!;
                  return ListView.builder(
                    itemCount: lifts.length,
                    itemBuilder: (context, index) {
                      Lift lift = lifts[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                              title: Text(
                                '${lift.departureStreet} to ${lift.destinationStreet}',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                'Seats: ${lift.numberOfSeats}, Amount per seat: ${lift.amountPerSeat}',
                                style: TextStyle(color: Colors.white70),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditLiftPage(lift: lift),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      await viewModel.deleteLift(lift.id!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


