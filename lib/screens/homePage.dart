import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rrr/screens/QrViewPage.dart';
import 'package:rrr/screens/dustSelection/dustSelectionPage.dart';
import 'package:rrr/utils/customRouteTransition.dart';

class HomePage extends StatefulWidget {
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

    Location.instance.onLocationChanged.listen((locData) {
      setState(() {
        _mylocation = locData;
        _center = LatLng(_mylocation.latitude, _mylocation.longitude);
      });
      _upDateMarker();
    });
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
                      child: CustomScrollViewContent(),
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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
          bottom: Radius.circular(24.0),
        ),
      ),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextField(
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
                        Navigator.push(
                          context,
                          CustomRouteTransition().createPageRoute(
                            navigateTo: DustSelectionPage(
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
                height: 18.0,
              ),
              Container(
                child: Text(
                  "Scan QR code or enter number",
                  style: TextStyle(fontSize: 24.0, color: Colors.grey),
                ),
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
