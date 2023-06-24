
import 'package:flutter/material.dart';



class DLSMLogo extends StatelessWidget {
  const DLSMLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/imgs/logo_title.png',
      fit: BoxFit.cover,
      width: 140,
      height: 70,
    );
  }
}
