import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dlsm_web/admin/dashboard.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> performLogin() async {
    final phoneNumber = _phoneNumberController.text;
    final password = _passwordController.text;

    try {
      final dio = Dio();
      final response = await dio.post(
        'https://drive-less-save-more-1.herokuapp.com/auth/signin',
        data: {
          'phoneNumber': phoneNumber,
          'password': password,
        },
      );
      print("login response: $response");

      final responseData = response.data as Map<String, dynamic>;
      final accessToken = responseData['access_token'] as String;
      final refreshToken = responseData['refresh_token'] as String;
      print("Access Token: $accessToken");

      // Do something with the access token and refresh token, such as storing them in shared preferences or passing them to the next screen.

      // Navigate to the Dashboard screen upon successful login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboard(
            title: 'Admin Dashboard',
          ),
        ),
      );
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          // Handle specific error response from the server
          print('Login failed: ${error.response!.data}');
        } else {
          // Handle other Dio errors (connection, timeouts, etc.)
          print('Login failed: ${error.message}');
        }
      } else {
        // Handle other types of errors
        print('Login failed: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                performLogin();
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
