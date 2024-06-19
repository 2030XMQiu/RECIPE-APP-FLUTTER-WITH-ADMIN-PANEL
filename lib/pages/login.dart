import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Admin/bottomnav.dart';
import 'package:recipe_app/pages/bottomnav.dart';
import 'package:recipe_app/pages/signup.dart';
import 'package:recipe_app/services/auth_gate.dart';
import 'package:recipe_app/widget/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> userLogin(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Check if the user is an admin
      QuerySnapshot adminSnapshot =
          await FirebaseFirestore.instance.collection("Admin").get();
      for (var result in adminSnapshot.docs) {
        Map<String, dynamic> adminData = result.data() as Map<String, dynamic>;
        if (adminData['username'] == email) {
          if (adminData['password'] == password) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminBottomNav()),
            );
            return; // Exit the function after successful admin login
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  "Your Password is not correct",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
            return; // Exit the function after incorrect password for admin
          }
        }
      }

      // Try to login as a regular user if not an admin
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthGate()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = "Wrong Email or Password";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Email Invalid";
      } else {
        errorMessage = "An error occurred";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 40.0,
            left: 20.0,
            right: 20.0,
            bottom: 40.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "images/login.jpg",
                  ),
                ),
                Center(
                  child: Text(
                    "Sign In",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Please enter the details below to continue.",
                  style: AppWidget.lightTextFieldStyle(),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Email",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Email"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Password",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      userLogin(context);
                    }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
