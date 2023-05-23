import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tourism_dept_app/screens/new_post.dart';

import '../screens/login_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    var user = FirebaseAuth.instance.currentUser;

    if (_selectedIndex == 1 && user == null) {
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
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Sign In'))
              ],
              title: const Text('Sign In'),
              content: const Text('Sign In to Post , Comment and Review'),
              titlePadding: const EdgeInsets.only(top: 20, left: 20),
              contentPadding: const EdgeInsets.all(20),
            );
          });
    } else if (_selectedIndex == 1 && user != null) {
      print(user);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const newpostScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      items: [
        BottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          backgroundColor: Colors.blueAccent.shade200,
        ),
        BottomBarItem(
          icon: const Icon(Icons.add_circle_outline_rounded),
          title: const Text('New Post'),
          backgroundColor: Colors.greenAccent.shade700,
        ),
      ],
      currentIndex: _selectedIndex,
      option: BubbleBarOptions(
        barStyle: BubbleBarStyle.horizotnal,
        opacity: 0.4,
        iconSize: 24,
        inkEffect: true,
      ),
      onTap: _onItemTapped,
    );
  }
}
