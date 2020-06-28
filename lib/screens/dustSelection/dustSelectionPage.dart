import 'package:flutter/material.dart';
import 'package:rrr/utils/customRouteTransition.dart';

import '../QrViewPage.dart';

class DustSelectionPage extends StatefulWidget {
  final String dustCode;
  final int dustbinType;
  DustSelectionPage({@required this.dustCode, @required this.dustbinType});
  @override
  _DustSelectionPageState createState() => _DustSelectionPageState();
}

class _DustSelectionPageState extends State<DustSelectionPage> {
  TextEditingController _editingController = TextEditingController();
  int _dustType;

  List<int> _selectedWasteImages = [];

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.dustCode ?? "");
    _dustType = widget.dustbinType;
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
                        controller: _editingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // focusColor: Colors.grey[200],
                          hintText: "Enter dustbin no.",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        onEditingComplete: () {
                          // todo
                        },
                      ),
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
                child: addressContainer(dustbinType: widget.dustbinType),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget addressContainer({@required int dustbinType}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
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
            height: MediaQuery.of(context).size.height * 0.15,
            // color: Col,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    "wcja ai ajs kaks ajij cajjca ajca ajc na",
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
          ),
          child: Center(
            child: image ?? Container(),
          ),
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
}
