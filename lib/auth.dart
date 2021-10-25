import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  // FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference gifts = FirebaseFirestore.instance.collection('gifts');

  Future addGift(String studentID, String fileType, String fileID) async {
    return gifts
        .add({
          'student_ID': studentID, // John Doe
          'file_type': fileType, // Stokes and Sons
          'file_ID': fileID // 42
        })
        .then((value) => print("Gift Added"))
        .catchError((error) => print("Failed to add gift: $error"));
  }
}
