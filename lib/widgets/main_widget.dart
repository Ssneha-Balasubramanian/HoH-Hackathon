import 'package:flutter/material.dart';
import 'weather_tile.dart';
import 'package:weather_icons/weather_icons.dart';

class MainWidget extends StatelessWidget{

  final temperature;
  final climate;
  String c = "";
  IconData i = Icons.thermostat_outlined;

  MainWidget({
    required this.temperature,
    required this.climate
  });

  @override
  Widget build(BuildContext context) {
    c = "${climate.toString()}";
    if(c.compareTo("Rain") == 0)
    {
      i = WeatherIcons.rain;
    }
    else if(c.compareTo("Clear") == 0)
    {
      i = WeatherIcons.day_sunny;
    }
    else if(c.compareTo("Thunderstorm") == 0)
    {
      i = WeatherIcons.thunderstorm;
    }
    else if(c.compareTo("Drizzle") == 0)
    {
      i = WeatherIcons.day_rain;
    }
    else if(c.compareTo("Snow") == 0)
    {
      i = WeatherIcons.day_snow;
    }
    else if(c.compareTo("Clouds") == 0)
    {
      i = WeatherIcons.cloud;
    }
    return SizedBox(
      height: 75,
      width: 160,
      child : Column(
        children: [
          Container(
            height:10,
            child: Column(
              children: [
              ],
            ),
          ),
          Flexible(
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  WeatherTile(icon: i, title: "${temperature.toInt().toString()} °C"),
                ],
              )),
        ],
      ),
    );
  }
}
