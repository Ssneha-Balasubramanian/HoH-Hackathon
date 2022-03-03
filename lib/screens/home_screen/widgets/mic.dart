import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untitled/widgets/HeaderWidget.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/NavigationBarWidget.dart';

class NeumorphicMic extends StatefulWidget {

  NeumorphicMic({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;
  @override
  _NeumorphicMicState createState() => _NeumorphicMicState();
}

class _NeumorphicMicState extends State<NeumorphicMic> {

  bool tapped = false;
  double neomorphicOffset = 0;
  double blurRadius = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children : <Widget> [
        GestureDetector(
      onTapDown: (_) {
        setState(() {
          tapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          tapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          tapped = false;
        });
      },
      child: Stack(
        children: [
          Positioned(
            bottom: tapped ? 0 : neomorphicOffset,
            right: tapped ? 0 : neomorphicOffset,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                micIcon(
                  context: context,
                  color: AppColors.highlightColor,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: tapped ? 0 : blurRadius,
                    sigmaY: tapped ? 0 : blurRadius,
                  ),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: tapped ? 0 : neomorphicOffset,
            left: tapped ? 0 : neomorphicOffset,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                micIcon(
                  context: context,
                  color: Colors.black54,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: tapped ? 0 : blurRadius,
                    sigmaY: tapped ? 0 : blurRadius,
                  ),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          micIcon(context: context, color: Colors.black38),
        ],
      ),
    ),
    ]
    );
  }

  Widget micIcon({
    required BuildContext context,
    Color color = Colors.black,
    // Color color = const Color(0xffff0048),
  }) {
    return Icon(
      Icons.mic_rounded,
      size: MediaQuery.of(context).size.height / 2,
      color: color,
    );
  }
}
