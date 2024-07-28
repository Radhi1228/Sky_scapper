import 'package:flutter/material.dart';
import 'package:weather_app/utils/helper/api_helper.dart';

import '../../../utils/helper/shared_helper.dart';
import '../model/home_model.dart';

class HomeProvider with ChangeNotifier
{

  bool theme = false;
  bool isTheme = false;
  ThemeMode mode = ThemeMode.dark;
  bool isOn = true;
  IconData themeMode = Icons.dark_mode;


  void setThemeData() async {
    theme = !theme;
    setData(isTheme: theme);
    isTheme = (await getData1())!;
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }
  void changeTheme() {
    isOn = !isOn;
    notifyListeners();
  }

  void getThemeData() async {
    if (await getData1() == null) {
      isTheme = false;
    } else {
      isTheme = (await getData1())!;
    }
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    }
    notifyListeners();
  }
  Future<HomeModel?>? model;
   void getWeatherAPI(String city)
   {
     APIHelper helper = APIHelper();
     model = helper.weatherAPICall(city);

     model!.then((value) {
       if(value != null)
         {
           notifyListeners();
         }
     },);
   }
}