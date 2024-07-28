import 'package:flutter/material.dart';
import 'package:weather_app/screen/detail/view/detail_screen.dart';
import 'package:weather_app/screen/home/view/home_screen.dart';
import 'package:weather_app/screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder> app_routes = {
  '/' :(c1) => const SplashScreen(),
  'home' :(c1) => const HomeScreen(),
  'detail' :(c1) => const DetailScreen(),
};