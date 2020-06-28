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
    var c = "0xFF" + color.toString();
    return Stack(
      children: <Widget>[
        Hero(
            tag: "${title.toString() + 0.toString()}",
            child: Container(
              color: Color(int.parse(c)),
              height: MediaQuery.of(context).size.height,
              child: Align(alignment: Alignment.bottomCenter,child: Image.asset("assets/images/plants.png")),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 24,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){},
                          onLongPress: (){},
                          child: Container(
                            height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Colors.black12, shape: BoxShape.circle),
                              child: Icon(
                                Icons.keyboard_backspace,
                                color: Colors.black,
                              ))),
                    ),
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
        ),
      ],
    );
  }
}
