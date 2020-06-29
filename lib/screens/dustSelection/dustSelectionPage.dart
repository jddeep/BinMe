import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rrr/constants/constants.dart';
import 'package:rrr/utils/customRouteTransition.dart';

import '../QrViewPage.dart';

class DustSelectionPage extends StatefulWidget {
  final String dustCode;
  final int dustbinType;
  final LatLng loaction;
  DustSelectionPage(
      {@required this.dustCode,
      @required this.dustbinType,
      @required this.loaction});
  @override
  _DustSelectionPageState createState() => _DustSelectionPageState();
}

class _DustSelectionPageState extends State<DustSelectionPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _editingController = TextEditingController();
  int _dustType;
  List<int> _selectedWasteImages = [];

  File _image;

  AnimationController animationController;
  String _address = "";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.dustCode ?? "");
    _dustType = widget.dustbinType;
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    );
    _getAddress(widget.loaction);
  }

  _showDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        animationController.repeat();
        bool _showRot = true;

        return StatefulBuilder(builder: (context, setState) {
          Timer.periodic(Duration(seconds: 4), (timer) {
            print("########");

            timer.cancel();
            animationController.stop();
            setState(() {
              _showRot = false;
            });
          });
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: _showRot
                    ? RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(animationController),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Center(
                            child: Icon(
                              Icons.monetization_on,
                              size: 40.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : Text("Coins: 500",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold)
                              .fontFamily,
                        )),
              ),
            ),
            actions: [
              !_showRot
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }),
                      ],
                    )
                  : Container(),
            ],
          );
        });
      },
    );
  }

  Future<File> _getImageFromGallery() async {
    File _file;
    await ImagePicker()
        .getImage(source: ImageSource.camera)
        .then((_pickedFile) {
      _file = File(_pickedFile.path);
    });

    return _file;
  }

  Future<String> _getAddress(LatLng location) async {
    final coordinates = new Coordinates(location.latitude, location.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} , ${first.addressLine}");
    setState(() {
      _address = "${first.featureName}, ${first.addressLine}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 50.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextField(
                        enabled: false,
                        controller: _editingController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold)
                                .fontFamily,
                            fontSize: 24,
                            letterSpacing: 10.5,
                            color: Color(0xFF2B4F50)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // focusColor: Colors.grey[200],
                          hintText: "123456",
                          hintStyle: TextStyle(
                              fontFamily: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold)
                                  .fontFamily,
                              fontSize: 24,
                              letterSpacing: 10.5,
                              color: Colors.black38),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF2B4F50), width: 2.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF2B4F50), width: 2.5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF2B4F50), width: 2.5)),
//                        fillColor: Colors.grey[200],
//                        filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF2B4F50),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                final pop = await Navigator.push(
                                  context,
                                  CustomRouteTransition().createPageRoute(
                                    navigateTo: QrViewPage(),
                                  ),
                                );
                                // todo: Do something with pop data (which is coming from qrview page).
                              },
                              child: Icon(
                                Icons.center_focus_strong,
                                size: 58.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: addressContainer(
                    dustbinType: widget.dustbinType,
                    location: widget.loaction,
                    address: _address),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: selectionContainer(),
              ),
              SizedBox(
                height: 16.0,
              ),
              dustSubTypeContainer(dustType: _dustType ?? widget.dustbinType),
              SizedBox(
                height: 16.0,
              ),
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: pickedImageContainer(_image),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: _selectedWasteImages.length > 0
          ? FloatingActionButton(
              onPressed: () {
                if (_image == null) {
                  _getImageFromGallery().then((_file) {
                    setState(() {
                      _image = _file;
                    });
                    print(_image.path);
                  });
                } else {
                  //show Dialog box
                  _showDialogBox();
                }
              },
              child: Center(
                  child: Icon(_image != null ? Icons.send : Icons.add_a_photo,
                      color: Colors.white)),
              backgroundColor: Colors.cyan,
            )
          : null,
    );
  }

  //#########################################################
  ///################### [WIDGETS] ##########################
  //#########################################################

  Widget addressContainer(
      {@required int dustbinType, LatLng location, String address}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_on,
                size: 60.0,
                color: Color(0xFF2B4F50),
              ),
            ),
            // SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              height: MediaQuery.of(context).size.height * 0.22,
              // color: Col,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      "$address",
                      //"${location.longitude}, ${location.latitude} sjaj ska ajka ksacka aakc akmc a akmjav ak akavkmak ",
                      style: TextStyle(
                          fontFamily: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w600)
                              .fontFamily,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
                        child: Chip(
                            label: Text("Red"),
                            backgroundColor: dustbinType == 1
                                ? Color(0xFFFFCCCC)
                                : Color(0xFFFFCCCC).withOpacity(0.3)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Chip(
                            label: Text("Blue"),
                            backgroundColor: dustbinType == 2
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.3)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Chip(
                          label: Text("Green"),
                          backgroundColor: dustbinType == 3
                              ? Colors.green
                              : Colors.green.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget selectionContainer() {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8.0,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        // height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _dustType,
                    activeColor: Colors.pink[200],
                    onChanged: (val) {
                      setState(() {
                        _dustType = val;
                      });
                    },
                  ),
                  Text(
                    "Non-Bio Degradable",
                    style: TextStyle(
                        fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                        fontSize: 18.0,
                        color: Colors.pink[200],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: _dustType,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setState(() {
                        _dustType = val;
                      });
                    },
                  ),
                  Text(
                    "Medical Waste",
                    style: TextStyle(
                        fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: _dustType,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      setState(() {
                        _dustType = val;
                      });
                    },
                  ),
                  Text(
                    "Bio Degradable",
                    style: TextStyle(
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dustSubTypeContainer({@required dustType}) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(10, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (_selectedWasteImages.contains(index)) {
                      _selectedWasteImages.remove(index);
                    } else {
                      _selectedWasteImages.add(index);
                    }
                  });
                },
                child: wasteImage(
                  dustType,
                  selected: _selectedWasteImages.contains(index),
                  image: Text(
                    "Waste Image ${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ), //todo: add image here instead of text.
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget wasteImage(/*Image*/ int dustType,
      {Widget image, bool selected = false}) {
    Color color;
    if (dustType == 1) {
      color = Colors.red.withOpacity(0.8);
    } else if (dustType == 2) {
      color = Colors.blue.withOpacity(0.8);
    } else {
      color = Colors.green.withOpacity(0.8);
    }
    return Stack(
      children: [
        Container(
          //? Image Container
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
                image: AssetImage(dustType == 1
                    ? 'assets/images/non_biodegradable.jpg'
                    : dustType == 2
                        ? 'assets/images/medical_waste.jpg'
                        : 'assets/images/biodegradable.jpg'),
                fit: BoxFit.cover),
          ),
          // child: Center(
          //   child: image ?? Container(),
          // ),
        ),
        selected
            ? Container(
                //? Image Container
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 68.0,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget pickedImageContainer(File _file) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          // color: Colors.amber,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.grey,
              child: Center(
                child: Image(
                  image: Image.file(_file).image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 0.0,
            right: 0.0,
            child: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _image = null;
                });
              },
            ))
      ],
    );
  }
}
