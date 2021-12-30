import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloudz/models/api_call_aqi.dart';
import 'package:cloudz/weather_report.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'models/api_call.dart';
import 'models/data_service.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key? key}) : super(key: key);

  @override
  _LocationServiceState createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
  @override
  void initState() {
    super.initState();
    getUserLocation();
    userWeather();
  }

//*api calls start
  var latitude = "";
  var longitude = "";

  WeatherResponse? _userLocation;
  late final userLocation;

  AirQualityIndex? _airQualityIndex;
  late final airQualityIndex;

  Future<dynamic> getUserLocation() async {
    bool _serviceEnabled;
    Location location = Location();
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      latitude = _locationData.latitude.toString();
      longitude = _locationData.longitude.toString();
    });
    print(latitude);
    print(longitude);
  }

  Future<void> userWeather() {
    return Future.delayed(const Duration(seconds: 1), () async {
      if (latitude.isNotEmpty) {
        userLocation =
            await _dataService.getWeatherFromCoordinates(latitude, longitude);
        airQualityIndex = await _dataService.getAirQuality(latitude, longitude);
        print('air quality report fetches succesfully!');
      } else {
        getUserLocation();
        userWeather();
      }
      setState(() {
        _userLocation = userLocation;
        _airQualityIndex = airQualityIndex;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherReport(
            weatherResponse: _userLocation, airQualityIndex: _airQualityIndex);
      }));
    });
  }

  final _dataService = DataService();
//*api calls end

  Future<bool> _onBackPress() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(body: SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.yellow : Colors.yellow[900],
            ),
          );
        },
      )),
    );
    // return AnimatedSplashScreen(
    //   splash: Icon(
    //     Icons.cloud,
    //     size: 100,
    //     color: Color.fromRGBO(247, 182, 12, 1),
    //   ),
    //   backgroundColor: Color.fromRGBO(10, 3, 60, 1),
    //   nextScreen: WeatherReport(
    //     weatherResponse: _userLocation,
    //     airQualityIndex: _airQualityIndex,
    //   ),
    //   duration: 5,
    //   splashTransition: SplashTransition.rotationTransition,
    // );
  }
}
