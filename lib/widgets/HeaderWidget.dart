import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../features/sendMessage.dart';
import 'WeatherInfo.dart';
import 'main_widget.dart';

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidget createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {

  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
    fetchCurrentLocation();
  }

  Widget build(BuildContext context) {

    return Center(
        child : Column
        (
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment : CrossAxisAlignment.center,
        children : <Widget> [
          SizedBox(
            height :45,
            width: 15,
          ),
        Row(
        children : <Widget> [ Text('EmergencyAssist',   style: const TextStyle(fontSize: 22,  color: Colors.red, fontFamily: 'PlayfairDisplay',  fontWeight: FontWeight.bold,         )),
        Spacer(),
        Text(
          DateFormat.yMMMEd().format(DateTime.now()),
          style: const TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay', color: Colors.red, fontWeight: FontWeight.bold),
        ),
        ]
    ),
 FutureBuilder<WeatherInfo>(
    future: futureWeather,
    builder: (context,snapshot) {
      if (snapshot.hasData) {
        return MainWidget(temperature: snapshot.data!.temperature,
          climate: snapshot.data!.climate,);
      }
      else if (snapshot.hasError) {
        return Center(
          child: Text("${snapshot.error}"),
        );
      }
      return const CircularProgressIndicator();
    }
  ),
        ],
  ),
    );
  }
}