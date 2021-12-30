import 'package:cloudz/models/api_call.dart';
import 'package:cloudz/models/api_call_aqi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'search_city.dart';
import 'widgets/weather_detail_card.dart';

class WeatherReport extends StatefulWidget {
  final WeatherResponse? weatherResponse;
  final AirQualityIndex? airQualityIndex;
  const WeatherReport({
    Key? key,
    required this.weatherResponse,
    required this.airQualityIndex,
  }) : super(key: key);

  @override
  _WeatherReportState createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  bool viewDetailsAqi = true;
  bool hideDetailsAqi = false;
  bool aqiDetails = false;

  // final String aqiRating = widget.airQualityIndex.tempAqiInfo.airQualityInfo.aqi;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String aqiRating = widget.airQualityIndex!.tempAqiInfo.airQualityInfo.aqi;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 3, 74, 1),
        leading: Icon(
          Icons.cloud,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchCity()));
              },
              icon: Icon(Icons.search))
        ],
        elevation: 0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.2,
                // 0.4,
                0.6,
                0.8,
              ],
              colors: [
Color(0xff100579),
                Color(0xff0C0459),
                Color.fromRGBO(12, 3, 74, 1),
                Color.fromRGBO(8, 3, 56, 1),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        Text(
                          "${widget.weatherResponse!.cityName}, ${widget.weatherResponse!.countryInfo.country}",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      widget.weatherResponse!.iconUrl,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                              '${widget.weatherResponse!.tempInfo.temperature}°C',
                              // style: TextStyle(fontSize: 60),
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "Feels Like ${widget.weatherResponse!.tempInfo.feelsLike}° C",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  // color: Colors.white,
                                  color: Color.fromRGBO(204, 204, 204, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.3,
                          child: Text(
                            widget.weatherResponse!.weatherInfo.description,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DetailsCard(
                        firstItem: 'min',
                        secondItem: 'max',
                        dataFirst: widget.weatherResponse!.tempInfo.minTemp,
                        dataSecond: widget.weatherResponse!.tempInfo.maxTemp,
                        size: size,
                        suffix1: '° C',
                        suffix2: '° C'),
                        SizedBox(height: 5,),
                    DetailsCard(
                        firstItem: 'humidity',
                        secondItem: 'pressure',
                        dataFirst: widget.weatherResponse!.tempInfo.humidity,
                        dataSecond: widget.weatherResponse!.tempInfo.pressure,
                        size: size,
                        suffix1: '%',
                        suffix2: 'mb'),
                        SizedBox(
                      height: 5,
                    ),

                    DetailsCard(
                        firstItem: 'visibility',
                        secondItem: 'cloud cover',
                        dataFirst: widget.weatherResponse!.visibility,
                        dataSecond:
                            widget.weatherResponse!.cloudsInfo.cloudCover,
                        size: size,
                        suffix1: 'm',
                        suffix2: '%'),
                        SizedBox(
                      height: 5,
                    ),

                    Container(
                      width: size.width * 0.9,
                      child: Card(
                        color: Color.fromRGBO(12, 3, 74, 1),
                        elevation: 15,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "air quality",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(204, 204, 204, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              //!  ******if else logic for aqi rating to quality (need to be upgraded)*****
                              aqiRating == '1'
                                  ? AirQuality(value: 'Good')
                                  : aqiRating == '2'
                                      ? AirQuality(value: 'Fair')
                                      : aqiRating == '3'
                                          ? AirQuality(value: "Moderate")
                                          : aqiRating == '4'
                                              ? AirQuality(value: 'Poor')
                                              : aqiRating == '5'
                                                  ? AirQuality(
                                                      value: 'Very poor')
                                                  : Container(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    viewDetailsAqi = !viewDetailsAqi;
                                    hideDetailsAqi = !hideDetailsAqi;
                                    aqiDetails = !aqiDetails;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: viewDetailsAqi,
                                      child: Text(
                                        'View Details V',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                204, 204, 204, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: hideDetailsAqi,
                                      child: Text(
                                        'Hide Details ⋀',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                204, 204, 204, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              detailsAqi(widget.airQualityIndex)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailsAqi(aqi) {
    return Visibility(
      visible: aqiDetails,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          AqiDetailCard(
              value1: 'pm2.5',
              data1: aqi!.tempAqiInfo.airQualityDetailsInfo.pm2_5,
              value2: 'pm10',
              data2: aqi!.tempAqiInfo.airQualityDetailsInfo.pm10),
          SizedBox(
            height: 10,
          ),
          AqiDetailCard(
              value1: 'co',
              data1: aqi!.tempAqiInfo.airQualityDetailsInfo.co,
              value2: 'no2',
              data2: aqi!.tempAqiInfo.airQualityDetailsInfo.no2),
          SizedBox(
            height: 10,
          ),
          AqiDetailCard(
              value1: 'so2',
              data1: aqi!.tempAqiInfo.airQualityDetailsInfo.so2,
              value2: 'o3',
              data2: aqi!.tempAqiInfo.airQualityDetailsInfo.o3)
        ],
      ),
    );
  }
}
