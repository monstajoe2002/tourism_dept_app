import 'package:flutter/material.dart';
import 'package:tourism_dept_app/widgets/categories.dart';
import 'package:tourism_dept_app/widgets/search_box.dart';

import '../widgets/bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hi there 👋', style: TextStyle(fontSize: 20.0)),
                Text(
                  'Take a virtual museum tour',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                SearchBox(),
                Categories()
              ],
            )),
        bottomNavigationBar: const BottomBar());
  }
}
