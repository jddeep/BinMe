import 'dart:math';

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
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/plantbg.png")),
            ),
            SingleChildScrollView(
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
                  InfoCard(color: "FFCCCC", title: "Reuse", text: reuseText,),
                  InfoCard(color: "FAE1B3", title: "Reduce", text: reduceText,),
                  InfoCard(color: "FAE1B3", title: "Recycle", text: recycleText,),
                  Container(
                    height: 300,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
