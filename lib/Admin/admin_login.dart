import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Admin/bottomnav.dart';
import 'package:recipe_app/widget/support_widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController UsernameController = new TextEditingController();
  TextEditingController UserpasswordController = new TextEditingController();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Admin panel",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Username",
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
                  controller: UsernameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Username"),
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
                  controller: UserpasswordController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  loginAdmin();
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
                        "Sign In",
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
            ],
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != UsernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your id is not correct",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else if (result.data()['password'] !=
            UserpasswordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your Password is not correct",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AdminBottomNav())));
        }
      });
    });
  }
}
