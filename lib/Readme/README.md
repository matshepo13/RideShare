# Get a Lift
GetLift is a ride-sharing app to help users especially students to save money on travel.
Users can offer or search for lifts to specific places, making it easy to plan trips with friends, like a holiday.
You can book or confirm if you're joining a ride and get details on where to meet, given the time, date and cost of the lift.
This new feature aims to make travel cheaper and more fun for everyone.
# Features

Onboarding: this is where the user first interacts with the app (User authentication)
• Log in ,Create Account and Forgot Password (Reset password)
Offer a Lift:
• Offer a new Lift by indicating your availability , address, cost and departere time & date and destination
• Update Lift Details /delete
• View Offered Lifts
 Search for a Lift:
• View/ search available Lifts by destination address
• View Lift details
Confirm or Cancel a Lift
• Confirm and View confirmed or booked Lift
• Cancel and view cancelled Lift (remove your self from the lift)

# Technologies Used

UI Framework for the view:
Flutter: The core UI framework for building natively compiled applications for mobile, web, and desktop from a single codebase.

Styling and Themes:
Flutter Material: Material design widgets and components.

UI Libraries:
Flutter Lottie: For rendering animations (welcome screen).

Routing:
Flutter Navigator: Built-in navigation system.
For the Controller

State Management:
Provider: To notify the UI about changes in the model.

Database:
Firebase: Comprehensive suite of services including Firestore for database, Authentication, Cloud Functions, and more.

Push Notifications:
Created Services responsibble for sending notifications

# Architecture
MVC: The app follows the MVC (Model-View-Controller) ensuring separation of concerns and maintaining a clean and organized codebase.
data: Contains data-related components following Clean Architecture principles:
ui: User interface components:
screens: RecyclerView adapters for displaying lifts in a listview
viewmodels: ViewModels for managing UI-related data and logic.
FIREBASE: used for user cloud authentication and data st

Directory Descriptions

    Model/: Contains data models used in the app.
    Services/: Contains service classes for authentication, database interactions, and notifications.
    Ui/: Contains UI components and pages for the app.
        components/: Reusable UI components.
        pages/: Pages representing different screens in the app.
    Utilities/: Utility classes and helpers.
    Viewmodels/: Contains ViewModel classes for managing state and logic.
    Firebase_config.dart: Configuration for Firebase.
    Main.dart: Entry point for the app.
    README.md: Project documentation.


Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or new features.
License

This project is licensed under the MIT License.

![alt text](<Screenshot from 2024-06-25 10-55-42.png>)
![alt text](<Screenshot from 2024-06-25 10-57-46.png>)
![alt text](<Screenshot from 2024-06-25 10-58-36.png>)
![alt text](<Screenshot from 2024-06-25 10-59-17.png>)
![alt text](<Screenshot from 2024-06-25 11-17-54.png>)
![alt text](<Screenshot from 2024-06-25 11-18-34.png>)
![alt text](<Screenshot from 2024-06-25 11-19-31.png>)
![alt text](<Screenshot from 2024-06-25 11-20-22.png>)
![Screenshot from 2024-06-25 13-55-11](https://github.com/matshepo13/FinalWTC/assets/120104041/260e0377-92fa-4713-abd1-d474547e2ce3)


