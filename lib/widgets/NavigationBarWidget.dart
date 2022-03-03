import 'package:flutter/material.dart';
import '../main.dart';

class NavigationBarWidget extends StatelessWidget
{
 final scaffoldkey;

  NavigationBarWidget({
    required this.scaffoldkey
});

  Widget build(BuildContext context)
  {

    return Container(
      color: Colors.red,
      height: 50,
      child: Row(
        children: <Widget>[
          GestureDetector(
              onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage()))
          },
              child: Image.asset(
                'assets/home.png',
                height: 40,
                color: Colors.white,
              )),
          const Spacer(),
          GestureDetector(
              onTap: () => {},
              child: Image.asset(
                'assets/help.png',
                height: 40,
                color: Colors.white,
              )),
          const Spacer(),
          GestureDetector(
              onTap: () {
                scaffoldkey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/settings2.png',
                height: 40,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}