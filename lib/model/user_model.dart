import 'package:firebase_auth/firebase_auth.dart';

class Contributor {
  final String uid;
  final String email;
  final String displayName;
  final String restrauntName;
  final String location;

  Contributor({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.restrauntName,
    required this.location,
  });

  factory Contributor.fromFirebase(UserCredential userCredential) {
    final firebaseUser = userCredential.user;
    return Contributor(
      uid: firebaseUser!.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      restrauntName: '', // Initialize with empty values, update as needed
      location: '',     // Initialize with empty values, update as needed
    );
  }
}
