import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget{
  IconData icon;
  String title;

  WeatherTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {

  return   ListTile(
      leading:
      Column(
        children: [
          Icon(icon, size:30, color: Colors.blueGrey,),
        ],
      ),
      title: Text(title, style: TextStyle(fontFamily: 'PlayfairDisplay', color: Colors.blueGrey), ),
    );
  }
}