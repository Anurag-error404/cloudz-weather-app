import 'package:cloudz/models/geocoding_api.dart';
import 'package:flutter/material.dart';

import 'models/api_call.dart';
import 'models/api_call_aqi.dart';
import 'models/data_service.dart';
import 'weather_report.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({Key? key}) : super(key: key);

  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  bool viewDetailsAqi = true;
  bool hideDetailsAqi = false;
  bool aqiDetails = false;
  bool loadingIndicator = false;
  var aqiRating = "";

  final _cityInputTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _userLocation;
  CityCoord? _cityCoord;

  AirQualityIndex? _airQualityIndex;
  late final airQualityIndex;

  // void _search() async {
  //   final response =
  //       await _dataService.getWeather(_cityInputTextController.text);
  //   setState(() => _response = response);
  // }

  void getUserCoordinates() async {
    final cityCoord =
        await _dataService.getCityCoordinates(_cityInputTextController.text);
    setState(() {
      _cityCoord = cityCoord;
    });
    print(_cityCoord!.cityCoordinates.latitude);
    print(_cityCoord!.cityCoordinates.longitude);
  }

  Future<void> aqiCity() {
    return Future.delayed(const Duration(seconds: 2), () async {
      if (_cityCoord != null) {
        airQualityIndex = await _dataService.getAirQuality(
            _cityCoord!.cityCoordinates.latitude,
            _cityCoord!.cityCoordinates.longitude);
        print('air quality report fetches succesfully!');
      }
      setState(() {
        _airQualityIndex = airQualityIndex;
      });
      searchResult();
    });
  }

  searchResult() {
    return Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return WeatherReport(
            weatherResponse: _userLocation, airQualityIndex: _airQualityIndex);
      },
    ));
  }

  void _search() async {
    final userLocation =
        await _dataService.getWeather(_cityInputTextController.text);
    setState(() {
      _userLocation = userLocation;
      loadingIndicator = !loadingIndicator;
    });
    getUserCoordinates();
    aqiCity();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 3, 74, 1),
        brightness: Brightness.dark,
        elevation: 0,
      ),
      backgroundColor: Color.fromRGBO(4, 18, 41, 1),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.2,
              0.5,
              0.8,
            ],
            colors: [
              Color.fromRGBO(20, 3, 96, 1),
              Color.fromRGBO(12, 3, 74, 1),
              Color.fromRGBO(10, 3, 60, 1),
              Color.fromRGBO(8, 3, 56, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.8,
                    height: 120,
                    child: TextField(
                      controller: _cityInputTextController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter City Name',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            fontSize: 20,
                          ),
                          fillColor: Color.fromRGBO(8, 3, 56, 1),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: _search,
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 35,
                      ))
                ],
              ),
              _airQualityIndex == null
                  ? Visibility(
                      visible: loadingIndicator,
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
