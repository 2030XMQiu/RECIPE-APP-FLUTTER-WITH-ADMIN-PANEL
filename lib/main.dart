import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:recipe_app/Admin/add_recipe.dart';
import 'package:recipe_app/Admin/admin_login.dart';

import 'package:recipe_app/Admin/bottomnav.dart';

import 'package:recipe_app/Admin/home.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/pages/onboarding.dart';

import 'package:recipe_app/pages/signup.dart';
import 'package:recipe_app/services/auth_gate.dart';
import 'package:recipe_app/services/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AdminLogin(),
      builder: EasyLoading.init(),
    );
  }
}
