import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/network_component/provider/network_provider.dart';
import 'package:weather_app/screen/home/provider/home_provider.dart';
import 'package:weather_app/utils/routes/app_routes.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
        ChangeNotifierProvider.value(value: NetworkProvider()),
      ],child: Consumer<HomeProvider>(builder: (context, value, child) {
      value.getThemeData();
      value.theme = value.isTheme;
      value.isOn == value.theme;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: app_routes,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: value.mode,
      );
    }),
    ));
}