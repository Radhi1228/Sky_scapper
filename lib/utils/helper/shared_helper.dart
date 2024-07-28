import 'package:shared_preferences/shared_preferences.dart';

void setData({required bool isTheme}) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setBool("theme", isTheme);
}

Future<bool?> getData1() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  return shr.getBool("theme");
}