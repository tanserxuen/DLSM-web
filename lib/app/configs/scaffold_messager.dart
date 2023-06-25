
import 'package:flutter/material.dart';

/// A global key for the scaffold messenger, used to show snackbars from anywhere
/// in the app. without having to pass the build context.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


// To allow access to scaffold messenger from anywhere in the app, without using ScaffoldMessenger.of(context)
ScaffoldMessengerState get scaffoldMessenger => scaffoldMessengerKey.currentState!;