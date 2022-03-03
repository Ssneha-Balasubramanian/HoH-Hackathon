import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

String Address = 'Help! I am facing an emergency. Please find me at -  ', final_gps_address = ' ', location ='';

Future<Position> _getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<String> GetAddressFromLatLong(Position position)async {
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemarks[0];
  Address += '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  return Address;
}

Future<void> fetchCurrentLocation()
async {
  Position position = await _getGeoLocationPosition();
  location ='${position.longitude},${position.latitude}';
  final_gps_address = await GetAddressFromLatLong(position);
}

String sendLatLong()
{
  fetchCurrentLocation();
  return location;
}

late TwilioFlutter twilioFlutter;
void sendSms(String msg) async {
  twilioFlutter = TwilioFlutter(
      accountSid: 'ACe172dd2e0a965442fb13b1eb48a9eb71',
      authToken: 'd4c97268afed4765719af367fc0b9c9d',
      twilioNumber: '+18456686394');
  twilioFlutter.sendSMS(
      toNumber: '+919940623219', messageBody: msg);
}