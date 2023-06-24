
import 'package:flutter/material.dart';



class BackgroundDecorationImages {
  
  static const car = DecorationImage(
    image: AssetImage("assets/imgs/background_car.png"),
    fit: BoxFit.cover,
    opacity: 0.75,
  );

  static const blueYellowGradient = DecorationImage(
    image: AssetImage('assets/imgs/background_blue_yellow_gradient.png'),
    fit: BoxFit.cover,
  );

  static const hexagon = DecorationImage(
    image: AssetImage('assets/imgs/background_hexagon.jpg'),
    fit: BoxFit.cover,
    opacity: 0.5,
  );

}



class BackgroundDecoration {

  static const car = BoxDecoration(
    image: BackgroundDecorationImages.car,
  );

  static const blueYellowGradient = BoxDecoration(
    image: BackgroundDecorationImages.blueYellowGradient,
  );

  static const hexagon = BoxDecoration(
    image: BackgroundDecorationImages.hexagon,
  );
}