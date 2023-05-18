import 'package:flutter/material.dart';
import 'package:tourism_dept_app/screens/loading_screen.dart';
import 'package:tourism_dept_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourism_dept_app/screens/login_screen.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _intialized = false;
  bool _error = false;
  void intializeflutterfire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _intialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    intializeflutterfire();
    super.initState();
  }

  Widget ShowAppropriateScreen() {
    if (_intialized) {
      {
        return const LoginScreen();
      }
    } else if (_error) {
      return const Text('Error');
    } else {
      return LoadingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
  }
}
