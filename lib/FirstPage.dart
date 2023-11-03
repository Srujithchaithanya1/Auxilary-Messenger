import 'package:miniproject/SignIn_Up/SingInPage.dart';
import 'package:flutter/material.dart';
import 'IntroPage.dart';
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: IntroPage(),
    );
  }
}
