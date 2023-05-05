import 'package:flutter/material.dart';
import 'package:marvel_app/modules/splash/presentation/page/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: const SplashScreen(),
  ));
}
