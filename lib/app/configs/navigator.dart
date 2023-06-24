
import "package:flutter/material.dart";


/// A global key for the navigator, used to navigate to a new page from anywhere
/// in the app. without having to pass the build context.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


/// Allows access to the navigator from anywhere in the app, without using Navigator.of(context)
NavigatorState get navigator => navigatorKey.currentState!;