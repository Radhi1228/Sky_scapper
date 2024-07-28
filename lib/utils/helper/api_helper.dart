import 'dart:convert';

import 'package:weather_app/screen/home/model/home_model.dart';
import 'package:http/http.dart' as http;

class APIHelper
{
  Future<HomeModel?> weatherAPICall(String city)async
  {
    String link = "https://api.openweathermap.org/data/2.5/weather?q=$city,&appid=ca26184fa1c93eb24eca3a5a35b8849e";

    var response = await http.get(Uri.parse(link));

    if(response.statusCode == 200)
    {
      var json = jsonDecode(response.body);
      HomeModel model = HomeModel.mapToModel(json);
      return model;
    }
    return null;
  }
}