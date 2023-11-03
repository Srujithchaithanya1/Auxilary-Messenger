import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproject/MyDataBase/FireBase_User.dart';
class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController new_emailId = TextEditingController();
  TextEditingController new_pwd = TextEditingController();
  TextEditingController new_pwd1 = TextEditingController();
  TextEditingController user_name = TextEditingController();

FireBase_User user = new FireBase_User();

  void dispose() {
    new_emailId.dispose();
    new_pwd.dispose();
    new_pwd1.dispose();
    user_name.dispose();
    super.dispose();
  }


  Future signUp() async {
    user.SignUp(new_emailId.text.trim(), new_pwd.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [

            

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: new_emailId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email address',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: new_pwd,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: new_pwd1,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: user_name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  SizedBox(height:20),
                  ElevatedButton(
                    onPressed: () {
                      if (new_pwd.text == new_pwd1.text) {
                        signUp();
                        Navigator.pop(context);
                      } else {
                        // Show an error message using a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Passwords do not match!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
