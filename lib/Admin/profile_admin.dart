import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/Admin/admin_login.dart';
import 'package:recipe_app/services/auth.dart';
import 'package:recipe_app/widget/support_widget.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

void logOut() {
  final authService = AuthMethods();
  authService.signOut();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffecefe8),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffecefe8),
          title: Text(
            "Profile",
            style: AppWidget.boldTextFieldStyle(),
          ),
        ),
        body: Container(
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                logOut();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 35.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Sign Out",
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
