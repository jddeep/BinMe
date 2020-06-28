import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
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
                    : Text("Points: 500"),
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

  Future<String> _getAddress(LatLng location )async {
    final coordinates = new Coordinates(location.latitude, location.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
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
                      child: Container(
                          child: Text(widget.dustCode ?? '123456'),
                          color: Colors.grey[200]),
                      // child: TextField(
                      //   controller: _editingController,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     // focusColor: Colors.grey[200],
                      //     hintText: "Enter dustbin no.",
                      //     enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(8.0),
                      //         borderSide:
                      //             BorderSide(color: Colors.transparent)),
                      //     focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(8.0),
                      //         borderSide:
                      //             BorderSide(color: Colors.transparent)),
                      //     fillColor: Colors.grey[200],
                      //     filled: true,
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: Colors.transparent,
                      //       ),
                      //     ),
                      //   ),
                      //   onEditingComplete: () {
                      //     // todo
                      //   },
                      // ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0)),
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
                    dustbinType: widget.dustbinType, location: widget.loaction, address : _address),
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
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.location_on,
                  size: 60.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Container(
            padding: const EdgeInsets.only(top: 8.0),
            height: MediaQuery.of(context).size.height * 0.18,
            // color: Col,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    "$address",
                    // "${location.longitude}, ${location.latitude}",
                    style: TextStyle(color: Colors.black),
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
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                          label: Text("lebel 1"),
                          backgroundColor: dustbinType == 1
                              ? Colors.red
                              : Colors.red.withOpacity(0.3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                          label: Text("lebel 2"),
                          backgroundColor: dustbinType == 2
                              ? Colors.blue
                              : Colors.blue.withOpacity(0.3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text("lebel 3"),
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
    );
  }

  Widget selectionContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      // height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: _dustType,
                onChanged: (val) {
                  setState(() {
                    _dustType = val;
                  });
                },
              ),
              Text(
                "Non-Bio Degradable",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: _dustType,
                onChanged: (val) {
                  setState(() {
                    _dustType = val;
                  });
                },
              ),
              Text(
                "Medical Waste",
                style: TextStyle(
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
                onChanged: (val) {
                  setState(() {
                    _dustType = val;
                  });
                },
              ),
              Text(
                "Bio Degradable",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
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
          width: MediaQuery.of(context).size.width * 0.5,
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
                width: MediaQuery.of(context).size.width * 0.5,
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
