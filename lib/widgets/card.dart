import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrr/constants/info.dart';
import 'package:rrr/screens/info_page_detail.dart';

class InfoCard extends StatelessWidget {
  var title;
  var text;
  var color;

  InfoCard({this.text = "NA", this.title = "NA", this.color = "NA"});

  @override
  Widget build(BuildContext context) {
    var c = "0x87" + color.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Hero(
          tag: "${title.toString() + 0.toString()}",
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
              child: Container(
                color: Color(int.parse(c)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InfoDetailPage(
                          color: color,
                          text: text,
                          title: title,
                        ),
                      ));
                    },
                    onLongPress: () {},
                    splashColor: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold)
                                    .fontFamily,
                                color: Colors.black.withOpacity(0.65),
                                fontSize: 32),
                          ),
                          Container(
                            height: 18,
                          ),
                          Text(
                            text,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                color: Colors.black.withOpacity(0.45),
                                fontSize: 18),
                          ),
                          Container(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
