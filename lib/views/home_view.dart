import 'dart:convert';
import 'dart:developer';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
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

    log('Position latitude ===> ${position.latitude}');
    log('Position longitude ===> ${position.longitude}');
    await getCurrentweather();
  }

  Future<void> getCurrentweather() async {
    final clien = Client();
    final AppiAdres =
        'https://api.openweathermap.org/data/2.5/weather?lat=37.421998333333335&lon= -122.084&appid=${AppText.myApiKey}';
    Uri uri = Uri.parse(AppiAdres);
    try {
      final joop = await clien.get(uri);
      final Murotjon = jsonDecode(joop.body);
      shaar = Murotjon['name'];

      final Kelvin = Murotjon['main']['temp'];
      temperatura = Kelvin - 285.79;
      setState(() {});
      contri = Murotjon['sys']['temp'];
      log('contri=====>$contri');
      log('shaar=====>$shaar');
      log('tepm====>${temperatura.toStringAsFixed(0)}');
    } catch (e) {
      print('$e');
    }
    ;
  }

  double temperatura = 0;
  String shaar = '';
  String contri = '';

  // abaYraiynAlipKel() async {
  //   var client = Client();

  //   // Uri url = Uri.parse(
  //   //     'api.openweathermap.org/data/2.5/weather?lat=37.421998333333335&lon= -122.084&appid=${AppText.myApiKey}');
  //   // final dannyiJoop = await client.get(url);
  //   // log('dannyi joop ===> $dannyiJoop');
  // }

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

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
                top: 20,
                left: 40,
                child: Text(
                  'country',
                  style: TextStyle(
                    fontSize: 60,
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
                  '$shaar',
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
