// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniproject/Screens/ChatScreen.dart';
import 'package:miniproject/Screens/Friends.dart';
import 'package:miniproject/SignIn_Up/SingInPage.dart';
import 'package:miniproject/FirstPage.dart';
import 'package:miniproject/SignIn_Up/LoggedIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
 

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "BLAH BLAH",
            appId: "BLAH BLAH",
            messagingSenderId: "674501955018",
            projectId: "mini-87efb",
            authDomain: "mini-87efb.firebaseapp.com",
            storageBucket: "mini-87efb.appspot.com",
            measurementId: "G-6P2BWV7HED"));
  } else {
    await Firebase.initializeApp();
  }
  
  runApp(FirstPage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Auxilary Messenger',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // A widget which will be started on application startup
      home: SplashScreen(),
    );
  }
}





class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Simulate the app loading process with a Future.delayed
      future: Future.delayed(Duration(seconds: 2)), // Adjust the duration as needed
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting, display your splash screen image
          return Scaffold(
            backgroundColor: Colors.white, // Customize background color
            body: Center(
              child: Lottie.asset(
                        'assets/splash.json', // Path to your animation asset
                        width: 500, // Adjust width as needed
                        height: 300, // Adjust height as needed
                      ),
            ),
          );
        } else {
          // When loading is complete, navigate to your main app screen
          return MyHomePage(title: 'Auxilary Messenger'); // Replace with your main app screen
        }
      },
    );
  }
}






class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({super.key, required this.title});
  ChatScreen myscreen = new ChatScreen("h");
  Friends f = new Friends();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,

      
      drawer: Drawer(
        child: Column(
          children: [
            Icon(
              size: 100,
              Icons.person,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  LoggedIn.signOut();
                },
                child: Text("SignOut")),
          ],
        ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // s.build(context),
            f.build(context),
            // myscreen.build(context),
          ],
        ),
      ),
    );
  }
}
