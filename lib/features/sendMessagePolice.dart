import 'dart:async';

import 'package:flutter/material.dart';

import '../drawers/SettingsDrawerWidget.dart';
import '../features/sendMessage.dart';
import '../widgets/CountdownWidget.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/NavigationBarWidget.dart';
import '../widgets/WeatherInfo.dart';


class CallPolicePage extends StatefulWidget {
  final scaffoldkey;

  const CallPolicePage({
    required this.scaffoldkey
  });

  @override
  _CallPolicePage createState() => _CallPolicePage(scaffoldkey: scaffoldkey,);
}

class _CallPolicePage extends State<CallPolicePage>{

  final scaffoldkey;
  _CallPolicePage({
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

