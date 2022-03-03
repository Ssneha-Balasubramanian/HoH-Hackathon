import 'package:flutter/material.dart';
import '../features/sendMessage.dart';
import '../features/SMSSent.dart';
import '../main.dart';
import 'dart:async';

class CountDownWidget extends StatefulWidget {
  _CountDownWidget createState() => _CountDownWidget();
}

class _CountDownWidget extends State<CountDownWidget> {

  var _scaffolKey = GlobalKey<ScaffoldState>();
  String greeting = "";
  late Timer _timer;
  int time = 10;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time < 0) {
          _timer.cancel();
          sendSms(final_gps_address);
          Navigator.push(context, MaterialPageRoute(builder: (context) => SMSSent(scaffoldkey: _scaffolKey,)));
        } else {
          greeting = "$time";
          time--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Sending SMS',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              )),
          const Text('  in',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              )),
          Text(greeting,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 3.0,
                    color: Colors.grey,
                  )
                ],
                fontSize: 225,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              )),
          ButtonTheme(
            child: ElevatedButton(
                onPressed: () {
                  _timer.cancel();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage()));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shadowColor: MaterialStateProperty.all(Colors.grey),
                  elevation: MaterialStateProperty.all(30.0),
                  minimumSize: MaterialStateProperty.all(const Size(120, 80)),
                ),
                child: const Text("Cancel")),
          ),
        ],
      ),
    );
  }
}
