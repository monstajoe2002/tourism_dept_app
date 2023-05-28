import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourism_dept_app/screens/NewExWidget.dart';
import 'package:tourism_dept_app/screens/login_screen.dart';

class Details_Screen extends StatefulWidget {
  const Details_Screen({super.key});

  @override
  State<Details_Screen> createState() => _Details_ScreenState();
}

class _Details_ScreenState extends State<Details_Screen> {
  @override
  var user = FirebaseAuth.instance.currentUser;
  List users_list = [];
  void addNewExpense(
      {String? comment,
      required String user_id,
      double? rating,
      required String user_email,
      required String user_name,
      required String post_id}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(post_id)
        .collection('Comment')
        .add({
          'comment text': comment,
          'rating': rating,
          'user_id': user_id,
          'user_email': user_email,
          'user_name': user_name
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    Navigator.of(context).pop();
  }

  void showNewExpenseBottomSheet(BuildContext ctx, String post_id_) {
    showModalBottomSheet(
        context: ctx,
        builder: (sheetContext) {
          print('show modal');
          return NewExWidget(callBackFunc: addNewExpense, post_id: post_id_);
        });
  }

  // Future<String> get_user_name(String user_id) async {
  //   String name = 'undefined';
  //   var result = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('userId', isEqualTo: user_id)
  //       .get()
  //       .then((QuerySnapshot QS) {
  //     QS.docs.forEach((doc) {
  //       name = doc["username"];
  //     });
  //   });
  //   return name;
  // }

  @override
  Widget build(BuildContext context) {
    final post_id_ = ModalRoute.of(context)!.settings.arguments;

    var commentsInstance = FirebaseFirestore.instance
        .collection('posts')
        .doc(post_id_ as String?)
        .collection('Comment');
    var myStream = commentsInstance.snapshots();
    // final AverageRating_instance = FirebaseFirestore.instance
    //     .collection('posts')
    //     .doc('0j28pN0UPyWH95eDbHWG');
    double averageRating = 0;
    // var ay7aga = AverageRating_instance.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map;
    //     print('average fl awel');
    //     average_rating = data['average_rating'];
    //     print(average_rating);
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              "Details",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(post_id_)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var averagedoc = snapshot.data;
              averageRating = averagedoc!['average_rating'];
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 270,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: Image.network(
                              averagedoc["imageUrl"],
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            averagedoc["name"].toString(),
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          RatingBarIndicator(
                              itemSize: 30,
                              rating: averageRating,
                              itemBuilder: (context, index) {
                                return const Icon(Icons.star,
                                    color: Colors.black);
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        const Icon(
                          Icons.location_on,
                          size: 25,
                          color: Color.fromARGB(255, 30, 134, 219),
                        ),
                        Text(averagedoc["location"],
                            style: const TextStyle(fontSize: 18, color: Colors.blue))
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(averagedoc["description"],
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Type',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text(averagedoc["type"],
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ]),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                      const Text(
                        "Recommendation ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        averagedoc["recommendation"],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Row(children: [
                        Text(
                          "Comments ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Icon(Icons.comment)
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: myStream,
                        builder: (ctx, strSnapshot) {
                          if (strSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var myDocuments = strSnapshot.data!.docs;
                          // var result = get_user_name('2wXImbz5mwSimFYy83v7vOw5MXm2');
                          //  print(result.toString());

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            itemBuilder: (itemCtx, index) {
                              var document = myDocuments[index].data() as Map;

                              return Card(
                                child: ListTile(
                                  // leading: CircleAvatar(
                                  //   backgroundColor: const Color(0xff764abc),
                                  //   child: Icon(
                                  //     Icons.account_circle,
                                  //     size: 25,
                                  //   ),
                                  // ),
                                  title: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_3_outlined,
                                        size: 25,
                                      ),
                                      Text(
                                        document['user_name'],
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    document['comment text'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 26, 25, 25)),
                                  ),
                                  // trailing: IconButton(
                                  //   iconSize: 50,
                                  //   onPressed: () {
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(
                                  //             SnackBar(content: Text('Icon ')));
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.delete,
                                  //   ),
                                  // ),
                                ),
                              );
                            },
                            itemCount: myDocuments.length,
                          );
                        },
                      ),
                      const Text('Rate The post'),
                      Center(
                        child: RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20),
                            onRatingUpdate: (value) async {
                              if (user == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('cancel')),
                                          TextButton(
                                              onPressed: () {
                                                print('dakhal el login');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen()));
                                              },
                                              child: const Text('Sign In'))
                                        ],
                                        title: const Text('Sign In'),
                                        content: const Text(
                                            'Sign In to Post , Comment and Review'),
                                        titlePadding: const EdgeInsets.only(
                                            top: 20, left: 20),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                      );
                                    });
                              } else {
                                print('value put');
                                print(value);
                                // Here I add the rating record
                                CollectionReference posts =
                                    FirebaseFirestore.instance
                                        .collection('posts');
                                posts
                                    .doc(post_id_)
                                    .collection('rating')
                                    .doc(user?.uid)
                                    .set(
                                        {'rating': value, 'user_id': user?.uid})
                                    .then((value) => print("rating Added"))
                                    .catchError((error) =>
                                        print("Failed to add rating: $error"));

                                // here I shall count the number of record and field value of avarege rating
                                int numberOfDocuments = 0;
                                double sumOfRatings = 0;
                                var samy = await posts
                                    .doc(post_id_)
                                    .collection('rating')
                                    .get()
                                    .then((QuerySnapshot QS) {
                                  for (var doc in QS.docs) {
                                    print('index');
                                    numberOfDocuments =
                                        numberOfDocuments + 1;
                                    num value = doc["rating"];
                                    print(value);
                                    sumOfRatings = (sumOfRatings + value);
                                  }
                                });

                                await posts.doc(post_id_).update({
                                  'average_rating':
                                      sumOfRatings/ numberOfDocuments
                                }).then((value) {
                                  print("sum_of_ratings");
                                  print(sumOfRatings);
                                  print("number_of_documents");

                                  print(numberOfDocuments);
                                }).catchError((error) =>
                                    print("Failed to add rating: $error"));
                              }
                            }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('pressed');

                          if (user == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('cancel')),
                                      TextButton(
                                          onPressed: () {
                                            print('dakhal el login');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          },
                                          child: const Text('Sign In'))
                                    ],
                                    title: const Text('Sign In'),
                                    content: const Text(
                                        'Sign In to Post , Comment and Review'),
                                    titlePadding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    contentPadding: const EdgeInsets.all(20),
                                  );
                                });
                          } else if (user != null) {
                            print(user);
                            showNewExpenseBottomSheet(context, post_id_!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Comment'),
                              SizedBox(width: 5),
                              Icon(Icons.add_comment_rounded, size: 24.0)
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
