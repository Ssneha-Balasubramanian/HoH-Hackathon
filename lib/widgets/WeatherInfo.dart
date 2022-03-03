import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<WeatherInfo> fetchWeather() async {
  const requestUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&units=metric&appid=1a129da5c70567e50cced9ebef5e630e';

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception("Error JSON");
  }
}

class WeatherInfo {
  final temperature;
  final climate;

  WeatherInfo({@required this.temperature, @required this.climate});

  factory  WeatherInfo.fromJson(Map<String, dynamic> json)
  {
    return WeatherInfo(
      temperature: json['main']['temp'],
      climate: json['weather'][0]['main'],
    );
  }

}
