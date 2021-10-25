import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gift_exchange/loading.dart';

class Result extends StatefulWidget {
  final String studentID;
  const Result({Key key, this.studentID}) : super(key: key);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    print('user id == ${widget.studentID}');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gifts')
            .doc(widget.studentID.toLowerCase())
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loading(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Loading(),
            );
          }
          print(snapshot.data['received'].toString());
          return snapshot.data['received'].toString().toLowerCase() == 'true'
              ? Center(
                  child: Container(
                  width: 700,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.pink[300]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 10),
                      SelectableText(
                        'You got the gift from ${snapshot.data['r_student_ID']}',
                        style: textStyle,
                      ),
                      Spacer(),
                      SelectableText(
                        'File ID : ${snapshot.data['r_file_ID']}',
                        style: textStyle,
                      ),
                      Spacer(),
                      SelectableText(
                        'File Type :  ${snapshot.data['r_file_type']}',
                        style: textStyle,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ))
              : Center(
                  child: Loading(),
                );
        },
      ),
    );
  }
}
