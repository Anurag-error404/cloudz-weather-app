import 'dart:convert';
import 'package:cloudz/models/geocoding_api.dart';

import 'api_call.dart';
import 'package:http/http.dart' as http;

import 'api_call_aqi.dart';

class DataService {
  final String apiKey = 'd62387d2a06eb38fd495fa342c7d1c65';
  // final String apiKey = '8d7c4559c7539ee68d49f3abf0046313';

  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<WeatherResponse> getWeatherFromCoordinates(
      String latitude, String longitude) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
      'appid': apiKey,
      'units': 'metric',
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<AirQualityIndex> getAirQuality(
      String latitude, String longitude) async {
    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
      'appid': apiKey,
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/air_pollution', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return AirQualityIndex.fromJson(json);

    // http://api.openweathermap.org/data/2.5/air_pollution?lat={lat}&lon={lon}&appid={API key}
  }

  Future<CityCoord> getCityCoordinates(String city) async {
    final queryParameters = {
      'q': city,
      'limit': '1',
      'appid': apiKey,
    };

    final uri =
        Uri.https('api.openweathermap.org', '/geo/1.0/direct', queryParameters);
    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return CityCoord.fromJson(json);
  }
}

// http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid={API key}
