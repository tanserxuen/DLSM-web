import 'package:dlsm_web/admin/dashboard.dart';
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
      home: const AdminDashboard(title: 'Admin Dashboard'),
    );
  }
}

// View user profile
// Approve rebate of user
// Generate report
