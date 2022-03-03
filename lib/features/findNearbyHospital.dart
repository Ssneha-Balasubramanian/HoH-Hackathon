import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/features/sendMessage.dart';

import 'nearbyPlaceModel.dart';
import 'sendMessage.dart';

Future<NearbyPlaces> fetchPlace() async {
  String location = sendLatLong();
  final response = await http.get(Uri.parse('https://api.geoapify.com/v2/places?categories=healthcare.hospital&filter=circle:' + location + ',5000&bias=proximity:' + location + '&lang=en&limit=20&apiKey=72eeb93b20e44427bbec3758ea74055f'));

  if (response.statusCode == 200) {

    final nearbyPlacesresp = nearbyPlacesFromJson(response.body);
    return nearbyPlacesresp;
  }
  else {

    throw Exception('Failed to load album');
  }
}


class FindHospitalPage extends StatefulWidget {
  const FindHospitalPage({Key? key}) : super(key: key);

  @override
  _FindHospitalPageState createState() => _FindHospitalPageState();
}

class _FindHospitalPageState extends State<FindHospitalPage> {
  late Future<NearbyPlaces> futureNearbyPlaces;

  @override
  void initState() {
    super.initState();
    futureNearbyPlaces = fetchPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hospitals near you'),
        backgroundColor: Colors.red,
      ),
      body: Center(
       child: FutureBuilder<NearbyPlaces>(
          future: futureNearbyPlaces,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPlaces(context, snapshot.data!);
              //return Text(snapshot.data!.type);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
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
              places.features[index].properties.name ?? "Hospital",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', ),
            ),
            subtitle: Text(places.features[index].properties.addressLine1.toString() + "\n" + places.features[index].properties.addressLine2.toString()),
          ),

        );
      },
    );
  }
}