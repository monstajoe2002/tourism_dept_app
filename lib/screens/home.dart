import 'package:flutter/material.dart';
import 'package:tourism_dept_app/widgets/categories.dart';
import 'package:tourism_dept_app/widgets/post_card.dart';
import 'package:tourism_dept_app/widgets/search_box.dart';

import '../widgets/bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: const [
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text('Logout'),
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
                    child: const Center(child: PostCard()),
                  )
                ],
              )),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
