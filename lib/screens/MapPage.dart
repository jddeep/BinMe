import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  margin: EdgeInsets.all(0.0),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Reuse",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold)
                                    .fontFamily,
                                color: Colors.white,
                                fontSize: 32),
                          ),
                          Container(
                            height: 18,
                          ),
                          Text(
                            "You can \"reuse\" materials in their original form instead of throwing them away, or pass those materials on to others who could use them too! Remember, one man's trash is another man's treasure! Here are some examples of reuse...",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                color: Colors.white.withOpacity(0.85),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  margin: EdgeInsets.all(0.0),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Reduce",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold)
                                    .fontFamily,
                                color: Colors.white,
                                fontSize: 32),
                          ),
                          Container(
                            height: 18,
                          ),
                          Text(
                            "Reduce/Reduction: to make something smaller or use less, resulting in a smaller amount of waste.\nYou can practice reduction by selecting products that do not have to be added to landfills or the waste stream in general.",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                color: Colors.white.withOpacity(0.85),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  margin: EdgeInsets.all(0.0),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Recycle",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold)
                                    .fontFamily,
                                color: Colors.white,
                                fontSize: 32),
                          ),
                          Container(
                            height: 18,
                          ),
                          Text(
                            "Recycle—don’t just toss everything in the trash. Lots of things can be remade into either the same kind of thing or new products. Making new items from recycled ones also takes less energy and fewer resources than making products from brand new materials.",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                color: Colors.white.withOpacity(0.85),
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
            ],
          ),
        ),
      ),
    );
  }
}
