import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourism_dept_app/screens/NewExWidget.dart';
import 'package:tourism_dept_app/screens/login_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var user = FirebaseAuth.instance.currentUser;
  List usersList = [];

  void addNewExpense({
    String? comment,
    required String userId,
    double? rating,
    required String userEmail,
    required String userName,
    required String postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comment')
        .add({
          'comment text': comment,
          'rating': rating,
          'user_id': userId,
          'user_email': userEmail,
          'user_name': userName,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    Navigator.of(context).pop();
  }

  void showNewExpenseBottomSheet(BuildContext ctx, String postId) {
    showModalBottomSheet(
      context: ctx,
      builder: (sheetContext) {
        print('show modal');
        return NewExWidget(callBackFunc: addNewExpense, post_id: postId);
      },
    );
  }

  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments;

    var commentsInstance = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId as String?)
        .collection('Comment');
    var myStream = commentsInstance.snapshots();
    double averageRating = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: const Text(
            "Details",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontFamily: 'YourDesiredFont',
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId as String?)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var averageDoc = snapshot.data;

          averageRating = averageDoc!['average_rating'];

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 270,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Image.network(
                        averageDoc["imageUrl"],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        averageDoc["name"].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'YourDesiredFont',
                        ),
                      ),
                      Text(
                        averageDoc["type"].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'YourDesiredFont',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: averageRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'YourDesiredFont',
                    ),
                  ),
                  SizedBox(height: 8),
                  StreamBuilder(
                    stream: myStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      var comments = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          var comment = comments[index];
                          return ListTile(
                            title: Text(comment["comment text"]),
                            subtitle: Text(comment["user_name"]),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (user != null) {
            showNewExpenseBottomSheet(context, postId as String);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
