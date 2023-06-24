import 'package:dlsm_web/admin/dashboard.dart';
import 'package:dlsm_web/admin/sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Dashboard',
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: SignIn(),
    );
  }
}

// View user profile
// Approve rebate of user
// Generate report
