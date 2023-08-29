import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreServices {
//   static saveUser(String name, email, uid) async {
//     await FirebaseFirestore.instance
//         .collection('contributors')
//         .doc(uid)
//         .set({'email': email, 'name': name});
//   }
// }

class FirestoreServices {
  static saveContributor(String name, String email, String uid) async {
    await FirebaseFirestore.instance
        .collection('contributors')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}
