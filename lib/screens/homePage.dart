import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rrr/screens/QrViewPage.dart';
import 'package:rrr/screens/dustSelection/dustSelectionPage.dart';
import 'package:rrr/utils/customRouteTransition.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  HomePage({@required this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;

  LatLng _center;
  LocationData _mylocation;

  Set<Marker> _markers = {};

  CustomRouteTransition _customRouteTransition = CustomRouteTransition();

  Future<LocationData> _getMyLocation() async {
    LocationData _locData;
    Location().getLocation().then((_locationData) {
      _locData = _locationData;
    });
    return _locData;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getMyLocation().then((loc) {
      setState(() {
        _mylocation = loc;
        _center = LatLng(_mylocation.latitude, _mylocation.longitude);
      });
    });
  }

  _showMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId("User"),
        position: LatLng(_mylocation.latitude, _mylocation.longitude),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  _upDateMarker() {
    _markers.removeWhere((m) => m.markerId.value == "User");
    _markers.add(
      Marker(
        markerId: MarkerId("User"),
        position: LatLng(_mylocation.latitude, _mylocation.longitude),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  var _streamLoc;

  @override
  void initState() {
    super.initState();
    _getMyLocation().then((loc) {
      setState(() {
        _mylocation = loc;
        _center = LatLng(_mylocation.latitude, _mylocation.longitude);
      });
      _showMarkers();
    });

    _streamLoc = Location.instance.onLocationChanged.listen((locData) {
      setState(() {
        _mylocation = locData;
        _center = LatLng(_mylocation.latitude, _mylocation.longitude);
      });
      _upDateMarker();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _streamLoc.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: _center != null
          ? Stack(
              // alignment: Alignment.center,
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  markers: _markers,
                  zoomControlsEnabled: false,
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.08,
                  minChildSize: 0.05,
                  maxChildSize: 0.4,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: CustomScrollViewContent(_center),
                    );
                  },
                ),
              ],
            )
          : Container(),
    );
  }
}

class CustomScrollViewContent extends StatelessWidget {
  final LatLng location;
  CustomScrollViewContent(this.location);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.0),
            bottom: Radius.circular(12.0),
          ),
        ),
        margin: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
//            color: Color(0xFF78ABAD)
          ),
                  child: CustomInnerContent(this.location),
        ),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  final LatLng location;
  CustomInnerContent(this.location);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        // SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 8.0, top: 12.0),
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Scan QR code or enter number",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.w600)
                            .fontFamily,
                        fontSize: 24.0,
                        color: Color(0xFF2B4F50)),
                  ),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextField(
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
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: Color(0xFF2B4F50), width: 2.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: Color(0xFF2B4F50), width: 2.5)),
//                        fillColor: Colors.grey[200],
//                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      onEditingComplete: () {
                        Navigator.push(
                          context,
                          CustomRouteTransition().createPageRoute(
                            navigateTo: DustSelectionPage(
                              loaction: this.location,
                              dustCode:
                                  "123456", //todo: need to be dynamic (fetch from qr code or textfield).
                              dustbinType: 1, //todo: need to be dynamic (fetch from qr code or textfield)
                            ),
                          ),
                        );
                      },
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
              SizedBox(
                height: 18.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
