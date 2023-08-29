import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_manage/contributor/contributor_dashboard.dart';
import 'package:waste_manage/user_type.dart';
import 'admin/admin_dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(); // Load the environment variables
  runApp(const MyApp());
}

Future<Map<String, dynamic>> getUserDataFromDatabase(String uid) async {
  // Replace this with your actual database retrieval logic
  // Example using Firestore
  var userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (userDoc.exists) {
    return userDoc.data() as Map<String, dynamic>;
  } else {
    return {};
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Add loading indicator
          } // ...
          else if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return FutureBuilder<Map<String, dynamic>>(
                future: getUserDataFromDatabase(
                    user.uid), // Implement this function
                builder: (context, userDataSnapshot) {
                  if (userDataSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (userDataSnapshot.hasData) {
                    bool isAdmin = userDataSnapshot.data?['role'] == 'admin';
                    if (isAdmin) {
                      return const AdminDashboard();
                    } else {
                      return const ContributorDashboard();
                    }
                  } else {
                    return const UserTypePage();
                  }
                },
              );
            } else {
              return const UserTypePage();
            }
          } else {
            return const UserTypePage();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
