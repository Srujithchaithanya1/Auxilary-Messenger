import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproject/MyDataBase/FireBase_User.dart';
import 'LoggedIn.dart';
import 'Registration_page.dart';
class SignInPage extends StatefulWidget {
  SignInState createState() => SignInState();
}

class SignInState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailId = TextEditingController();
  final pwd = TextEditingController();

  final new_emailId = TextEditingController();
  final new_pwd = TextEditingController();
  final new_pwd1 = TextEditingController();
  final user_name = TextEditingController();




  FireBase_User user = new FireBase_User();

  void dispose() {
    emailId.dispose();
    pwd.dispose();
    new_emailId.dispose();
    new_pwd.dispose();
    new_pwd1.dispose();
    user_name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoggedIn();
          }
          return Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Column(
                    children: [

                      

                      Text(
                'Login',
                style: TextStyle(
                        // color: Color.fromARGB(255, 1, 44, 18),
                        fontStyle: FontStyle.italic),
              ),
                    ],
                  )),
              backgroundColor: Colors.green,
              // elevation: 50,
              // toolbarHeight: 170,

              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      
                      
                      // Lottie.network("https://assets10.lottiefiles.com/packages/lf20_XpVCMJTSQt.json"),
                                         //  Image.asset('assets/icons/mini_project_icon.jpeg'),
                      Lottie.asset(
                        'assets/splash.json', // Path to your animation asset
                        width: 500, // Adjust width as needed
                        height: 300, // Adjust height as needed
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                                top: Radius.circular(20))),
                
                        height: 350,
                        width: 330,
                
                        // color: Color.fromARGB(222, 5, 238, 168),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                                        
                                      
                                        
                            Divider(
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(height: 25),
                                        
                            SizedBox(
                              width: double.infinity,
                              child: TextField(
                                controller: emailId,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email address'),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 300,
                              child: TextField(
                                obscureText:true,
                                controller: pwd,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    
                                    labelText: 'Password'),
                              ),
                            ),
                            SizedBox(height:20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 0,
                            ),
                                onPressed: () async {
                                  final errorMessage = await signIn();
                                  if (errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                              }, child: Text('SignIn')),
                              SizedBox(height: 10,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 0,
                            ),
                              onPressed: () {
                        
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                                    );
                        
                        
                                    
                                  },
                                  child: Text('Create New Account'),
                                )
                          ]),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // Future<String?> signIn() async {
  //   user.Login(emailId.text.trim(), pwd.text.trim());
  // }


  Future<String?> signIn() async {
  try {
    await user.Login(emailId.text.trim(), pwd.text.trim());
    // If login is successful, return null or some success indicator.
    return null;
  } catch (e) {
    // Handle the error and return an error message.
    return 'No account found or incorrect credentials.';
  }
}


  Future signUp() async {
    user.SignUp(
      new_emailId.text.trim(), new_pwd.text.trim());
  }
}
