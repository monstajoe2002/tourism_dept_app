import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourism_dept_app/widgets/categories.dart';
import 'package:tourism_dept_app/widgets/post_card.dart';
import 'package:tourism_dept_app/widgets/search_box.dart';

import '../widgets/bottom_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
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
                    child: Center(
                        child: GestureDetector(
                      child: const PostCard(),
                      onTap: () {
                        var postsInstance =
                            FirebaseFirestore.instance.collection('Post');
                        var postsSnapshots = postsInstance.snapshots();
                        postsSnapshots.listen((snapshot) {
                          snapshot.docs.forEach((doc) {
                            print(doc.data()['Name']);
                          });
                        });
                      },
                    )),
                  )
                ],
              )),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
