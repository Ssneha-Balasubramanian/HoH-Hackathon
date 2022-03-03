import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RecordAudio.dart';
import 'VideoRecorder.dart';

class SettingsDrawer extends StatefulWidget
{
  final scaffoldkey;

  SettingsDrawer({
    required this.scaffoldkey
  });

  @override
  _SettingsDrawer createState() => _SettingsDrawer(scaffoldkey: scaffoldkey,);
}
class _SettingsDrawer extends State<SettingsDrawer>
{
  final scaffoldkey;

  _SettingsDrawer({
    required this.scaffoldkey
  });


bool state = false;
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
         GestureDetector(
         child : Image.asset(
            'assets/arrow.png',
            height: 40,
            color: Colors.black,
            alignment: Alignment.topLeft,
          ),
           onTap: (){
           Navigator.pop(context);
           },
         ),
           Spacer(),
           DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child:   Text('Emergency  Assist', style: TextStyle(fontSize: 40, color: Colors.white, fontFamily: 'PlayfairDisplay', ), textAlign: TextAlign.center, ),
           ),
          Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.mic_sharp),
                title:  Text('Record audio', style: TextStyle(fontFamily: 'PlayfairDisplay', ),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                     builder: (context) => RecordAudioPage(scaffoldkey: scaffoldkey,)));
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_sharp),
                title: const Text('Record video', style: TextStyle(fontFamily: 'PlayfairDisplay', ),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => VideoRecorderApp(scaffoldkey: scaffoldkey,)));
                },
              ),
              ListTile(
                leading: const Icon(Icons.close_sharp),
                title: Text('Close', style: TextStyle(fontFamily: 'PlayfairDisplay', ),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}