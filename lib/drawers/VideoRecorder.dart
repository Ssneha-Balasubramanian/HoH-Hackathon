import 'package:flutter/material.dart';

import 'RecordVideo.dart';

class VideoRecorderApp extends StatefulWidget {
  final scaffoldkey;

  VideoRecorderApp({
    required this.scaffoldkey
  });

  _VideoRecorderApp createState() => _VideoRecorderApp(scaffoldkey: null);
}
class _VideoRecorderApp extends State<VideoRecorderApp> {
  final scaffoldkey;

  _VideoRecorderApp({
    required this.scaffoldkey
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoRecorderExample(

      ),
    );
  }
}

Future<void> main() async {
  runApp(VideoRecorderApp(scaffoldkey: null,));
}