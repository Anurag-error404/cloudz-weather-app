import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsCard extends StatelessWidget {
  final String firstItem;
  final String secondItem;
  final String dataFirst;
  final String dataSecond;
  final String suffix1;
  final String suffix2;
  final Size size;

  const DetailsCard({
    Key? key,
    required this.firstItem,
    required this.secondItem,
    required this.dataFirst,
    required this.dataSecond,
    required this.size,
    required this.suffix1,
    required this.suffix2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height*0.2,
      width: size.width * 0.9,
      child: Card(
        shadowColor: Color(0xff080338),
        elevation: 15,
        color: Color.fromRGBO(12, 3, 74, 1),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            ContentData(
                title: firstItem,
                data: dataFirst,
                suffix: suffix1),
            ContentData(
                title: secondItem,
                data: dataSecond,
                suffix: suffix2),
          ],
        ),
      ),
    );
  }
}

class ContentData extends StatelessWidget {
  final String title;
  final String data;
  final String suffix;

  const ContentData(
      {Key? key,
      required this.title,
      required this.data,
      required this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ,
      // width: size.width * 0.3,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.transparent),

      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Color.fromRGBO(
                    204, 204, 204, 1),
              ),
            ),
          ),
          Text(
            data + suffix,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AirQuality extends StatelessWidget {
  final String value;
  const AirQuality(
      {Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AqiDetailCard extends StatelessWidget {
  final String value1;
  final String value2;
  final String data1;
  final String data2;
  const AqiDetailCard(
      {Key? key,
      required this.value1,
      required this.value2,
      required this.data1,
      required this.data2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              value1,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(
                      204, 204, 204, 1),
                ),
              ),
            ),
            Text(
              data1 + 'μg/m3',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Text(
              value2,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(
                      204, 204, 204, 1),
                ),
              ),
            ),
            Text(
              data2 + 'μg/m3',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
