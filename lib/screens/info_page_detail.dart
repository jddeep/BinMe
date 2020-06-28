import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDetailPage extends StatelessWidget {
  var color;
  var title;
  var text;

  InfoDetailPage(
      {this.color = Colors.white, this.title = "NA", this.text = "NA"});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
            tag: "${title.toString() + 0.toString()}",
            child: Container(
              color: color,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold)
                              .fontFamily,
                          color: Colors.black,
                          fontSize: 32),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      text,
                      maxLines: null,
                      style: TextStyle(
                          fontFamily: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold)
                              .fontFamily,
                          color: Colors.black45,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
