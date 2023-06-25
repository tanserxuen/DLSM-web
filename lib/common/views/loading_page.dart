
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {

    final logo = Image.asset(
      'assets/imgs/logo_transparent.png',
      width: 250,
      fit: BoxFit.fitWidth,
    );

    const loadingText = Text(
      "Loading",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );

    final loadingAnimationWidget = Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Colors.blue,
        rightDotColor: Colors.black,
        size: 40,
      ),
    );

    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logo,
          loadingText,
          loadingAnimationWidget,
        ],
      ),
    );
  }
}
