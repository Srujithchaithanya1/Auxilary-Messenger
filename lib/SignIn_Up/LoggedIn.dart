import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproject/main.dart';
import 'package:flutter/material.dart';

class LoggedIn extends StatelessWidget {
  static signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text('HealthyMe',style: TextStyle(color: Color.fromARGB(255, 1, 44, 18),fontStyle: FontStyle.italic),)),
      //   backgroundColor: Color.fromARGB(255, 162, 236, 212),),
      body: MyApp(),
      // body: SignInPage(),
    );
  }
}
