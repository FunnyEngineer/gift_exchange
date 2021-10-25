import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_exchange/auth.dart';
import 'package:gift_exchange/loading.dart';
import 'package:gift_exchange/result.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final stuNumController = TextEditingController();
  final fileIDController = TextEditingController();
  final fileTypeController = TextEditingController();
  CollectionReference gifts = FirebaseFirestore.instance.collection('gifts');
  bool loading = false;
  String localStudentID = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    stuNumController.dispose();
    fileIDController.dispose();
    fileTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            width: 500,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                color: Colors.pink[300]),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 64.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: stuNumController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Student ID',
                      labelStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: fileTypeController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.white)),
                      labelText: 'File Type',
                      labelStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: fileIDController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.white)),
                      labelText: 'File ID',
                      labelStyle:
                          TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    primary: Colors.pink,
                  ),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                      localStudentID = stuNumController.text.toLowerCase();
                    });
                    DocumentReference user_gift =
                        gifts.doc(stuNumController.text);
                    await user_gift
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        print('Original data: ${documentSnapshot.data()}');
                        user_gift
                            .update({
                              'student_ID': stuNumController.text,
                              'file_type': fileTypeController.text,
                              'file_ID': fileIDController.text,
                              'received': false,
                              'r_student_ID': null,
                              'r_file_ID': null,
                              'r_file_type': null,
                            })
                            .then((value) => {
                                  print("Gift Updated"),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Result(
                                            studentID: stuNumController.text
                                                .toLowerCase()),
                                      )),
                                })
                            .catchError(
                                (error) => print("Failed to add gift: $error"));
                      } else {
                        user_gift
                            .set({
                              'student_ID': stuNumController.text,
                              'file_type': fileTypeController.text,
                              'file_ID': fileIDController.text,
                              'received': false,
                              'r_student_ID': null,
                              'r_file_ID': null,
                              'r_file_type': null,
                            })
                            .then((value) => {
                                  print("Gift Added"),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Result(
                                            studentID: stuNumController.text
                                                .toLowerCase()),
                                      )),
                                })
                            .catchError(
                                (error) => print("Failed to add gift: $error"));
                      }
                    });
                  },
                  child: Text(
                    ' Send Your Gift!! ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
  }
}
