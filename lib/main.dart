import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:untitled/drawers/SettingsDrawerWidget.dart';
import 'package:untitled/widgets/HeaderWidget.dart';
import 'features/findNearbyHospital.dart';
import 'features/findNearbyPoliceStation.dart';
import 'features/SendMessageFire.dart';
import 'features/sendMessageAmbulance.dart';
import 'features/sendMessage.dart';
import 'features/sendMessagePolice.dart';
import 'widgets/WeatherInfo.dart';
import 'dart:async';

//main
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard of hearing hackathon',
      home:  ShowCaseWidget(
        autoPlay: true,
        autoPlayDelay: const Duration(milliseconds: 2000),
        builder: Builder(builder: (context) => const AppPage()),
      )),
  );
}

class AppPage extends StatefulWidget {

  const AppPage({Key? key,}) : super(key: key);


  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  final _scaffolKey = GlobalKey<ScaffoldState>();

  final key1 = GlobalKey();
  final key2 = GlobalKey();
  final key3 = GlobalKey();
  final key4 = GlobalKey();
  final key5 = GlobalKey();

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
      key: _scaffolKey,
      backgroundColor: Colors.white,
      drawer: SettingsDrawer(scaffoldkey: _scaffolKey,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HeaderWidget(),
            const Spacer(),
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                  width: 10,
                ),
                Showcase(
                  key: key1,
                  description: 'Press this icon to view nearby Hospitals',
                  showArrow: false,
                  showcaseBackgroundColor: Colors.red,
                  shapeBorder: const CircleBorder(),
                  descTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                  overlayPadding: const EdgeInsets.all(8),
                  contentPadding: const EdgeInsets.all(16),
                  onTargetClick: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const FindHospitalPage()));
                  },
                  disposeOnTap: true,
                  child: GestureDetector(
                    onTap: () {		    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const FindHospitalPage()));
                    },
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/hospital.png'),
                    ),
                  ),
                ),
                const Spacer(),
                Showcase(
                  key: key2,
                  description: 'Press this icon to view nearby Police Stations',
                  showArrow: false,
                  showcaseBackgroundColor: Colors.red,
                  shapeBorder: const CircleBorder(),
                  descTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                  overlayPadding: const EdgeInsets.all(8),
                  contentPadding: const EdgeInsets.all(16),
                  disposeOnTap: true,
                  onTargetClick: () {         Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const FindPoliceStationPage()));
                  },
                  child: GestureDetector(
                    onTap: () {         Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const FindPoliceStationPage()));
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      child: Image.asset(
                        'assets/policestation.png',height: 120,    width: 120,                 ),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: const <Widget>[
                SizedBox(
                  width: 15,
                ),
                Text('Find Hospitals', style: TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold)),
                Spacer(),
                Text('Find Police Stations', style: TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Showcase(
                  key: key3,
                  showArrow: false,
                  description: 'Press this icon to call the Fire Station',
                  showcaseBackgroundColor: Colors.red,
                  shapeBorder: const CircleBorder(),
                  descTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                  overlayPadding: const EdgeInsets.all(8),
                  contentPadding: const EdgeInsets.all(16),
                  onTargetClick: () {        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CallFirePage(scaffoldkey: _scaffolKey,)));
                  },
                  disposeOnTap: true,
                  child: GestureDetector(
                    onTap: () {        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CallFirePage(scaffoldkey: _scaffolKey,)));
                    },
                    child: Container(
                      width: 180,
                      height: 150,
                      child: Image.asset('assets/fire.png', height: 150, width: 170,),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                ),
                const Spacer(),
                Showcase(
                  key: key4,
                  shapeBorder: const CircleBorder(),
                  description: 'Press this icon to call an Ambulance',
                  showArrow: false,
                  showcaseBackgroundColor: Colors.red,
                  descTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                  overlayPadding: const EdgeInsets.all(8),
                  contentPadding: const EdgeInsets.all(16),
                  onTargetClick: () {        Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CallAmbulancePage(scaffoldkey: _scaffolKey,)));
                  },
                  disposeOnTap: true,
                  child: GestureDetector(
                    onTap: () {        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CallAmbulancePage(scaffoldkey: _scaffolKey,)));
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/ambu.png'),
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            Row(children: const <Widget>[
              SizedBox(
                width: 20,
              ),
              Text('Call Fire Station', style: TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold)),
              Spacer(),
              Text('Call Ambulance', style: TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold)),
              SizedBox(
                width: 12,
              ),
            ]),
            const Spacer(),
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 140,
                  width: 110,
                ),
                Showcase(
                  key: key5,
                  description: 'Press this icon to call the Police',
                  showArrow: false,
                  shapeBorder: const CircleBorder(),
                  showcaseBackgroundColor: Colors.red,
                  descTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                  //  overlayPadding: EdgeInsets.all(5),
                  // contentPadding: EdgeInsets.all(10),
                  onTargetClick: () {         Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CallPolicePage(scaffoldkey: _scaffolKey,)));
                  },
                  disposeOnTap: true,
                  child: GestureDetector(
                    onTap: () {         Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CallPolicePage(scaffoldkey: _scaffolKey,)));
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      child: Image.asset('assets/police.png', height: 140, width: 140),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: const Text('Call Police Station', style: TextStyle(fontSize: 18, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold)),
              alignment: Alignment.topCenter,
            ),
            const Spacer(),
            Container(
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
                      onTap: () {
                        setState(() {
                          ShowCaseWidget.of(context)!.startShowCase([
                            key1,
                            key2,
                            key3,
                            key4,
                            key5
                          ]);
                        });
                      },
                      child: Image.asset(
                        'assets/help.png',
                        height: 40,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        _scaffolKey.currentState?.openDrawer();
                      },
                      child: Image.asset(
                        'assets/settings2.png',
                        height: 40,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

