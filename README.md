# Barber App

Welcome to the Barber App! This Flutter application allows users to book services at a barber shop, view available services, and manage their appointments.

## Features

- User registration and login with Firebase Authentication
- Book appointments by selecting a date and time
- View available services
- User-friendly interface with responsive design

## Screenshots

<div style="display:flex">
    <img src="screenshots/HomeScreen.png" alt="Home Screen" width="200"/>
<img src="screenshots/BookingScreen.png" alt="Booking Screen" width="200"/>
<img src="screenshots/HistoryScreen.png" alt="History Screen" width="200"/>
<img src="screenshots/InforScreen.png" alt="Info Screen" width="200"/>
</div>

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install) on your local machine.
- You have a Firebase project set up. If not, create one [here](https://console.firebase.google.com/).

### Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/barber-app.git
    cd barber-app
    ```

2. **Install dependencies:**
    ```sh
    flutter pub get
    ```

3. **Set up Firebase:**

    - Go to the Firebase Console and create a new project.
    - Enable Authentication (Email/Password) in the Authentication section.
    - Download the `google-services.json` file for Android and place it in the `android/app` directory.
    - For iOS, download the `GoogleService-Info.plist` file and place it in the `ios/Runner` directory. 

4. **Configure Firebase in your Flutter app:**

    Ensure you have the necessary dependencies in your `pubspec.yaml`:
    ```yaml
    dependencies:
      firebase_core: latest_version
      firebase_auth: latest_version
      cloud_firestore: latest_version
      flutter:
        sdk: flutter
    ```

    Initialize Firebase in your `main.dart`:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:firebase_core/firebase_core.dart';

    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(MyApp());
    }

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Barber App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(), // Your initial screen
        );
      }
    }
    ```

### MVC Architecture

The Barber App follows the MVC (Model-View-Controller) architecture to maintain a clean and organized codebase.

- **Model:** This layer is responsible for representing the data and business logic. The models in this app include `UserModel` and `ServiceModel`. These classes define the structure of user and service data and contain methods to manipulate the data.

  Example `UserModel`:
  ```dart
  class UserModel {
    final String id;
    final String name;
    final String email;
    final String image;

    UserModel({required this.id, required this.name, required this.email, required this.image});
  }
  
Example `ServiceWidget`:
```dart
class ServiceWidget extends StatelessWidget {
  final ServiceModel service;
  final UserModel user;

  const ServiceWidget({required this.service, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(service.name),
          Text(service.description),
          Text('\$${service.price}'),
          // Add more UI elements here
        ],
      ),
    );
  }
}
    
Example `ServiceController`:
```dart
class ServiceController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ServiceModel>> getServicesStream() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}



