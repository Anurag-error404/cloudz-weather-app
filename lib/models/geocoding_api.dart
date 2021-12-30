class CityCoordinates {
  String city;
  String latitude;
  String longitude;

  CityCoordinates(
      {required this.city, required this.latitude, required this.longitude});

  factory CityCoordinates.fromJson(Map<String, dynamic> json) {
    final city = json['ctiy'].toString();
    final latitude = json['lat'].toString();
    final longitude = json['lon'].toString();

    return CityCoordinates(
        city: city, latitude: latitude, longitude: longitude);
  }
}

class CityCoord {
  CityCoordinates cityCoordinates;

  CityCoord({required this.cityCoordinates});
  factory CityCoord.fromJson(List<dynamic> json) {
    final tempCityCoordInfo = json[0];
    final tempCity = CityCoordinates.fromJson(tempCityCoordInfo);

    return CityCoord(cityCoordinates: tempCity);
  }
}
