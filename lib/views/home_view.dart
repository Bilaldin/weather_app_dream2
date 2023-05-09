import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/texts/app_text.dart';
import 'package:weather_app/views/search_view.dart';

class Adam {
  String name = 'Timur';
  int age = 123;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

String? name;
List<String> names = [
  'Kubat',
];
Set<String> name1 = {''};
Map<String, String> map = {'': ''};

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    showWeather();
    super.initState();
  }

  Future<void> showWeather() async {
    final position = await getPosition();
    await abaYraiynAlipKel();
    log('Position latitude ===> ${position.latitude}');
    log('Position longitude ===> ${position.longitude}');
  }

  String temperatura = '15';
  String oblast = 'osh';

  abaYraiynAlipKel() async {
    var client = http.Client();

    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=37.421998333333335&lon= -122.084&appid=${AppText.myApiKey}');
    final dannyiJoop = await client.get(uri);
    log('dannyi joop ===> $dannyiJoop');
  }

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.near_me,
            size: 40,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchView()));
                },
                icon: Icon(
                  Icons.location_city,
                  size: 40,
                ))
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 90,
                left: 40,
                child: Text(
                  '$temperatura °C',
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 150,
                child: Text(
                  ' ⛅',
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 150,
                child: Text(
                  ' ⛅',
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 220,
                left: 100,
                right: 0,
                child: Text(
                  'Jiluu \n kiyinip 👕   \n chyk',
                  style: TextStyle(
                    fontSize: 55,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '$oblast',
                  style: TextStyle(
                    fontSize: 55,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
