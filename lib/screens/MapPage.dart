import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrr/constants/info.dart';
import 'package:rrr/widgets/card.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Learn how\nyou can contribute",
                  style: TextStyle(
                      fontFamily:
                          GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)
                              .fontFamily,
                      color: Colors.black,
                      fontSize: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Tap on each of these cards to learn more.",
                  style: TextStyle(
                      fontFamily:
                          GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)
                              .fontFamily,
                      color: Colors.black45,
                      fontSize: 18),
                ),
              ),
              InfoCard(color: Color(0xFFFFCCCC), title: "Reuse", text: reuseText,),
              InfoCard(color: Color(0xFFFAE1B3), title: "Reduce", text: reduceText,),
              InfoCard(color: Color(0xFFD9F2D4), title: "Recycle", text: recycleText,),
              Container(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
