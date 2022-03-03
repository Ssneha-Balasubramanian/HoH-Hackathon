import 'package:flutter/material.dart';

import '../drawers/SettingsDrawerWidget.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/NavigationBarWidget.dart';
import '../widgets/WeatherInfo.dart';
import 'sendMessage.dart';

class SMSSent extends StatefulWidget {
  final scaffoldkey;

  SMSSent({
    required this.scaffoldkey
  });

  @override
  _SMSSent createState() => _SMSSent(scaffoldkey: scaffoldkey,);
}

class _SMSSent extends State<SMSSent> {

  final scaffoldkey;

  _SMSSent({
    required this.scaffoldkey
  });


  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
    fetchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        backgroundColor: Colors.white,
        drawer: SettingsDrawer(scaffoldkey: scaffoldkey,),
        body: Center(
            child : Column(
              children : <Widget>[
                HeaderWidget(),
                const Spacer(),
                const ImageIcon(
                  AssetImage("assets/done.png"),
                  color: Colors.green,
                  size: 172,
                ),
                const Text('',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    )),
                const Text('SMS sent!',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                NavigationBarWidget(scaffoldkey: scaffoldkey,),
              ],
            ),
        ),
    );
  }
}


