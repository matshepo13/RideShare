import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lifts_app/ui/pages/introduction/create_account_page.dart';
import 'package:lifts_app/ui/pages/introduction/welcome_page.dart';
import 'package:lifts_app/ui/pages/introduction/sign_in_page.dart';
import 'package:lifts_app/ui/pages/main_page.dart';
import 'package:lifts_app/ui/pages/notifications/notification.dart';
import 'package:lifts_app/viewmodels/notification_viewmodel.dart';
import 'package:lifts_app/services/notification_service.dart';
import 'package:lifts_app/viewmodels/created_lifts_viewmodel.dart';
import 'package:lifts_app/ui/pages/offer_ride/created_lifts.dart';
import 'package:lifts_app/ui/pages/activities/accepted_ride_details.dart'; // Adjust as per your actual path
import 'package:lifts_app/model/lift_model.dart'; // Assuming Lift model is defined here


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotificationViewModel(NotificationService()),
        ),
        ChangeNotifierProvider(
          create: (context) => CreatedLiftsViewModel(), // Provide CreatedLiftsViewModel here
        ),
      ],
      child: MaterialApp(
        title: 'Your App Name',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/', // Set initial route to '/'
        routes: {
          '/': (context) => MyHomePage(title: 'Your App Title'), // MyHomePage as initial route
          '/register': (context) => CreateAccountPage(), // Route to CreateAccountPage
          '/loginRider': (context) => SignInPage(), // Route to SignInPage
          '/main': (context) => const MyHomePage(title: 'Home'),
          '/notifications': (context) => NotificationPage(), // Add NotificationPage route
          '/created_lifts': (context) => CreatedLiftsPage(), // Add CreatedLiftsPage route
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/accepted_ride_details') {
            final args = settings.arguments as Map<String, dynamic>;
            final lift = args['lift'] as Lift;
            final acceptedTimestamp = args['acceptedTimestamp'] as DateTime;
            return MaterialPageRoute(
              builder: (context) => AcceptedRideDetailPage(
                lift: lift,
                acceptedTimestamp: acceptedTimestamp,
              ),
            );
          }
          return MaterialPageRoute(builder: (context) => MyHomePage(title: 'Unknown Page'));
        },
      ),
    );
  }
}
