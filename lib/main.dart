import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cardless/screens/scan_card_screen.dart';
import 'package:cardless/screens/card_image_screen.dart';
import 'package:cardless/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CardLess());
}

class CardLess extends StatelessWidget {
  const CardLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Less',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AnimatedSplashScreen(
              nextScreen: HomeScreen(),
              splash: Image.asset('assets/images/cardless.png'),
            ),
        '/home': (context) => HomeScreen(),
        '/card_image': (context) => CardImageScreen(),
        '/add_card': (context) => ScanCardScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
