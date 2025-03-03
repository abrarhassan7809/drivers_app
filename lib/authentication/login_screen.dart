import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if(!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email is not valid!");
    }
    else if(passwordTextEditingController.text.length < 4) {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialogs(message: "Processing, Please wait...",);
      },
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim()
        ).catchError((msg) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: $msg");
        })

    ).user;

    if(firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (_) => MySplashScreen()));
    }
    else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Not Login Successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset("asset/images/logo1.png"),
              ),

              SizedBox(height: 10,),
              Text(
                "Login as a Driver",
                style: TextStyle(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10,),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Email",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                ),
              ),

              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18
                  ),
                ),
              ),

              SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
                },
                child: Text(
                  "Don't have an Account? Register Here",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

