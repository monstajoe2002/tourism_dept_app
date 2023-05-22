import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourism_dept_app/screens/loading_screen.dart';
import 'package:tourism_dept_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourism_dept_app/screens/login_screen.dart';
import 'package:tourism_dept_app/screens/new_post.dart';

//import 'screens/login_screen.dart';
//import 'screens/signup_screen.dart';

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
  //
  void intializeflutterfire() async {
    try {
      await Firebase.initializeApp();
      print('awel khatwa ');
      setState(() {
        _intialized = true;
      });
      print('el intialization et3ayare = 1');
    } catch (e) {
      setState(() {
        print('el intialization et3ayare = 0');
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
      print('el error b 1');
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
        //home: ShowAppropriateScreen(),
        home: _intialized != true
            ? LoadingScreen()
            : StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  }
                  if (userSnapshot.hasData) {
                    //the snapshot returned from the auth sdk has something inside means user is authenticated
                    print('user authenticated flz');
                    return Home();
                  }
                  return const LoginScreen();
                }));
    //initialRoute: '/',
    //routes: {
    //'/': (context) => Home(),
    //},
    //  );
  }
}
