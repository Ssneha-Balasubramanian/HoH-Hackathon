import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'nearbyPlaceModel.dart';
import 'sendMessage.dart';

Future<NearbyPlaces> fetchPlace() async {
  String location = sendLatLong();
  print(location);
  final response = await http.get(Uri.parse('https://api.geoapify.com/v2/places?categories=service.police&filter=circle:' + location + ',5000&bias=proximity:' + location + '&lang=en&limit=20&apiKey=72eeb93b20e44427bbec3758ea74055f'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final nearbyPlacesresp = nearbyPlacesFromJson(response.body);
    //print(response.body);
    //print(nearbyPlacesresp.features[2].properties.name);
    //print(nearbyPlacesresp.features.length);
    return nearbyPlacesresp;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class FindPoliceStationPage extends StatefulWidget {
  const FindPoliceStationPage({Key? key}) : super(key: key);

  @override
  _FindPoliceStationPageState createState() => _FindPoliceStationPageState();
}

class _FindPoliceStationPageState extends State<FindPoliceStationPage> {
  late Future<NearbyPlaces> futureNearbyPlaces;

  @override
  void initState() {
    super.initState();
    futureNearbyPlaces = fetchPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        FutureBuilder<NearbyPlaces>(
          future: futureNearbyPlaces,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPlaces(context, snapshot.data!);
              //return Text(snapshot.data!.type);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
              //return Text("hello");
            }
            //print(futureNearbyPlaces);
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  ListView _buildPlaces(BuildContext context, NearbyPlaces places) {
    return ListView.builder(
      itemCount: places.features.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              places.features[index].properties.name ?? "Police Station ",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', ),
            ),
            subtitle: Text(places.features[index].properties.addressLine1.toString() + "\n" + places.features[index].properties.addressLine2.toString() + "\n"),

          ),
        );
      },
    );
  }
}