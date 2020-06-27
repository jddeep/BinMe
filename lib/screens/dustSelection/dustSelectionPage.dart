import 'package:flutter/material.dart';
import 'package:rrr/utils/customRouteTransition.dart';

import '../QrViewPage.dart';

class DustSelectionPage extends StatefulWidget {
  final String dustCode;
  DustSelectionPage({@required this.dustCode});
  @override
  _DustSelectionPageState createState() => _DustSelectionPageState();
}

class _DustSelectionPageState extends State<DustSelectionPage> {
  TextEditingController _editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.dustCode ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent)),
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
              SizedBox(
                height: 16.0,
              ),
              addressContainer(),
              SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                height: MediaQuery.of(context).size.height * 0.3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addressContainer() {
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
                        backgroundColor: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text("lebel 1"),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text("lebel 1"),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
