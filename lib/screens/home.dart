import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourism_dept_app/screens/loading_screen.dart';
import 'package:tourism_dept_app/screens/login_screen.dart';
import 'package:tourism_dept_app/widgets/categories.dart';
import 'package:tourism_dept_app/widgets/post_card.dart';
import 'package:tourism_dept_app/widgets/search_box.dart';

import '../widgets/bottom_bar.dart';

class Home extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var postsInstance = FirebaseFirestore.instance.collection('posts');
    var stream = postsInstance.snapshots();
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              InkWell(
                child: ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Logout'),
                  onTap: () {
                    if (user != null) {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  },
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hi there 👋', style: TextStyle(fontSize: 20.0)),
                  const Text(
                    'Take a virtual museum tour',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  const SearchBox(),
                  const Categories(),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height, 
                      child: Center(
                          child: StreamBuilder<QuerySnapshot>(
                        stream: stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingScreen();
                          }
                          if (!snapshot.hasData) {
                            return LoadingScreen();
                          }
                          var posts = snapshot.data!.docs;
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                var document = posts[index].data() as Map;
                                return PostCard(
                                    title: document['name'],
                                    location: document['location'],
                                    imageUrl: document['imageUrl'],
                                    category: document['type']);
                              },
                              itemCount: posts.length);
                        },
                      )),
                    ),
                  )
                ],
              )),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
