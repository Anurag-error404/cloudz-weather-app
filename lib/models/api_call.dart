/*
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55, 
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
  },
  "sys": {
    "country": "US",
  },
  "name": "Mountain View",
  }                                           
*/
class WeatherInfo {
  final String keyword;
  final String description;
  final String icon;

  WeatherInfo(
      {required this.keyword, required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final keyword = json['main'];
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(keyword: keyword, description: description, icon: icon);
  }
}

class TemperatureInfo {
  var temperature;
  var feelsLike;
  var maxTemp;
  var minTemp;
  var humidity;
  var pressure;

  TemperatureInfo(
      {required this.temperature,
      required this.feelsLike,
      required this.maxTemp,
      required this.minTemp,
      required this.humidity,
      required this.pressure});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'].toString();
    final feelsLike = json['feels_like'].toString();
    final maxTemp = json['temp_max'].toString();
    final minTemp = json['temp_min'].toString();
    final humidity = json['humidity'].toString();
    final pressure = json['pressure'].toString();
    return TemperatureInfo(
        temperature: temperature,
        feelsLike: feelsLike,
        maxTemp: maxTemp,
        minTemp: minTemp,
        humidity: humidity,
        pressure: pressure);
  }
}

class CountryInfo {
  final String country;

  CountryInfo({required this.country});

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    final country = json['country'];
    return CountryInfo(country: country);
  }
}

class CoordianteInfo {
  final double lat;
  final double lon;

  CoordianteInfo({required this.lat, required this.lon});

  factory CoordianteInfo.fromJson(Map<String, dynamic> json) {
    final lat = json['lat'];
    final lon = json['lon'];
    return CoordianteInfo(lat: lat, lon: lon);
  }
}

class WindSpeed {
  final String speed;
  final String direction;

  WindSpeed({required this.speed, required this.direction});

  factory WindSpeed.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'].toString();
    final direction = json['deg'].toString();

    return WindSpeed(speed: speed, direction: direction);
  }
}

class Clouds {
  final String cloudCover;

  Clouds({required this.cloudCover});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    final cloudCover = json['all'].toString();

    return Clouds(cloudCover: cloudCover);
  }
}

class WeatherResponse {
  final String cityName;
  final String visibility;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final CoordianteInfo coordianteInfo;
  final CountryInfo countryInfo;
  final WindSpeed windSpeedInfo;
  final Clouds cloudsInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.visibility,
      required this.tempInfo,
      required this.weatherInfo,
      required this.coordianteInfo,
      required this.countryInfo,
      required this.windSpeedInfo,
      required this.cloudsInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final visibility = json['visibility'].toString();

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final coordianteInfoJson = json['coord'];
    final coordianteInfo = CoordianteInfo.fromJson(coordianteInfoJson);

    final countryInfoJson = json['sys'];
    final countryInfo = CountryInfo.fromJson(countryInfoJson);

    final windSpeedInfoJson = json['wind'];
    final windSpeedInfo = WindSpeed.fromJson(windSpeedInfoJson);

    final cloudsInfoJson = json['clouds'];
    final cloudsInfo = Clouds.fromJson(cloudsInfoJson);

    return WeatherResponse(
        cityName: cityName,
        visibility: visibility,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        coordianteInfo: coordianteInfo,
        countryInfo: countryInfo,
        windSpeedInfo: windSpeedInfo,
        cloudsInfo: cloudsInfo);
  }
}
