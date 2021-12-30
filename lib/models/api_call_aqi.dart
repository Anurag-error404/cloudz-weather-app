// {
//   "list": [
//     {
//       "dt": 1606147200,
//       "main": {
//         "aqi": 4.0
//       },
//       "components": {
//         "co": 203.609,
//         "no": 0.0,
//         "no2": 0.396,
//         "o3": 75.102,
//         "so2": 0.648,
//         "pm2_5": 23.253,
//         "pm10": 92.214,
//         "nh3": 0.117
//       }
//     }
//   ]
// }

class AirQualityInfo {
  var aqi;

  AirQualityInfo({required this.aqi});

  factory AirQualityInfo.fromJson(Map<String, dynamic> json) {
    final aqi = json['aqi'].toString();
    return AirQualityInfo(aqi: aqi);
  }
}

class AirQualityIndexInfo {
  final AirQualityInfo airQualityInfo;
  final AirQualityDetailsInfo airQualityDetailsInfo;

  AirQualityIndexInfo(
      {required this.airQualityInfo, required this.airQualityDetailsInfo});

  factory AirQualityIndexInfo.fromJson(Map<String, dynamic> json) {
    final airQualityInfoJson = json['main'];
    final airQualityInfo = AirQualityInfo.fromJson(airQualityInfoJson);

    final airQualityDetailsJson = json['components'];
    final airQualityDetails =
        AirQualityDetailsInfo.fromJson(airQualityDetailsJson);

    return AirQualityIndexInfo(
        airQualityInfo: airQualityInfo,
        airQualityDetailsInfo: airQualityDetails);
  }
}

// class AirQualityDetails {
//   final AirQualityDetailsInfo airQualityDetailsInfo;

//   AirQualityDetails({required this.airQualityDetailsInfo});

//   factory AirQualityDetails.fromJson(Map<String, dynamic> json) {
//     final airQualityDetailsJson = json['components'];
//     final airQualityDetails =
//         AirQualityDetailsInfo.fromJson(airQualityDetailsJson);

//     return AirQualityDetails(airQualityDetailsInfo: airQualityDetails);
//   }
// }

class AirQualityDetailsInfo {
  var co;
  var no;
  var no2;
  var o3;
  var so2;
  var pm2_5;
  var pm10;
  var nh3;

  AirQualityDetailsInfo(
      {required this.co,
      required this.no,
      required this.no2,
      required this.o3,
      required this.so2,
      required this.pm2_5,
      required this.pm10,
      required this.nh3});

  factory AirQualityDetailsInfo.fromJson(Map<String, dynamic> json) {
    final co = json['co'].toString();
    final no = json['no'].toString();
    final no2 = json['no2'].toString();
    final o3 = json['o3'].toString();
    final so2 = json['so2'].toString();
    final pm2_5 = json['pm2_5'].toString();
    final pm10 = json['pm10'].toString();
    final nh3 = json['nh3'].toString();

    return AirQualityDetailsInfo(
        co: co,
        no: no,
        no2: no2,
        o3: o3,
        so2: so2,
        pm2_5: pm2_5,
        pm10: pm10,
        nh3: nh3);
  }
}

class AirQualityIndex {
  final AirQualityIndexInfo tempAqiInfo;

  AirQualityIndex({required this.tempAqiInfo});

  factory AirQualityIndex.fromJson(Map<String, dynamic> json) {
    final tempAqiInfoJson = json['list'][0];
    final tempAqiInfo = AirQualityIndexInfo.fromJson(tempAqiInfoJson);

    return AirQualityIndex(tempAqiInfo: tempAqiInfo);
  }
}
