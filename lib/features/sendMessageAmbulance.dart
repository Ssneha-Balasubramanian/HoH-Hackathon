import 'dart:async';

import 'package:flutter/material.dart';

import '../drawers/SettingsDrawerWidget.dart';
import '../features/sendMessage.dart';
import '../widgets/CountdownWidget.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/NavigationBarWidget.dart';
import '../widgets/WeatherInfo.dart';


class CallAmbulancePage extends StatefulWidget {
  final scaffoldkey;

  CallAmbulancePage({
    required this.scaffoldkey
  });

  @override
  _CallAmbulancePage createState() => _CallAmbulancePage(scaffoldkey: scaffoldkey,);
}

class _CallAmbulancePage extends State<CallAmbulancePage> {

  final scaffoldkey;

  _CallAmbulancePage({
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
          CountDownWidget(),
          const Spacer(),
          NavigationBarWidget(scaffoldkey: scaffoldkey,),
        ],
      ),
      ),
      );
  }
}

