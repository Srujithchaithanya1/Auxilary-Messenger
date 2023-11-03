import 'package:flutter/material.dart';
import 'package:miniproject/SignIn_Up/SingInPage.dart';
import 'package:miniproject/SignIn_Up/Registration_page.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<String> changingTexts = [
    'Welcome to Our Chatting App!',
    'Discover the Power of Real-time Messaging',
    'Communicate without language barriers'
  ];
  int currentTextIndex = 0;
  double _translationX = 0.0;

  void changeText() {
    setState(() {
      currentTextIndex = (currentTextIndex + 1) % changingTexts.length;
      _translationX = -30.0; // Set negative translation in pixels to move left
    });

    // Delay the reset of the translation
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _translationX = 0.0; // Reset translation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Auxiliary Messenger',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.withOpacity(0.7),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 10.0), // Add padding to move the Lottie animation up
                child: Lottie.asset("assets/animation_ln.json"),
              ),
              Container(
                width: 300,
                height: 300,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      changingTexts[currentTextIndex],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    AnimatedContainer(
                      transform: Matrix4.translationValues(
                        _translationX,
                        0.0,
                        0.0,
                      ),
                      duration: Duration(milliseconds: 300),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          changeText();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("Login"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("SignUp"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: IntroPage(),
//   ));
// }
