import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rrr/screens/signup/loginPage.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseUser user;
  ProfilePage({@required this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _userData;
  GoogleSignIn googleSignIn = GoogleSignIn();

  void getUserData() async {
    await Firestore.instance.collection('users').getDocuments().then((docs) {
      _userData = docs.documents[0].data;
    }).whenComplete(() {
      setState(() {
        print('Name:' + _userData['name']);
      });
    });
  }

  _logOut() {
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_userData == null)
      return Center(
        child: Container(
          height: 50.0,
          width: 50.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.amber,
          ),
        ),
      );
    else
      return Scaffold(
          body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.black.withOpacity(0.8)),
            clipper: getClipper(),
          ),
          Positioned(
              width: 350.0,
              // top: MediaQuery.of(context).size.height / 5,
              child: Column(
                children: <Widget>[
                  Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(image: NetworkImage(
                              // 'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'
                              _userData['profile_image']), fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ])),
                  SizedBox(height: 50.0),
                  Text(
                    "${widget.user.displayName}", //_userData['name'],
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 35.0,
                        ),
                        Text(
                          _userData['coins'],
                          style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Column(
                    children: [
                      Text('Recent items you Recycled: '),
                      SizedBox(height: 10.0),
                      ListTile(
                        title: Text(_userData['recent_item1']),
                        leading: Icon(Icons.donut_small),
                      ),
                      ListTile(
                        title: Text(_userData['recent_item2']),
                        leading: Icon(Icons.donut_small),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  // Container(
                  //     height: 30.0,
                  //     width: 95.0,
                  //     child: Material(
                  //       borderRadius: BorderRadius.circular(20.0),
                  //       shadowColor: Colors.greenAccent,
                  //       color: Colors.green,
                  //       elevation: 7.0,
                  //       child: GestureDetector(
                  //         onTap: () {},
                  //         child: Center(
                  //           child: Text(
                  //             'Edit Name',
                  //             style: TextStyle(
                  //                 color: Colors.white,),
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  // SizedBox(height: 25.0),
                  Container(
                      height: 30.0,
                      width: 95.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            _logOut();
                          },
                          child: Center(
                            child: Text(
                              'Log out',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ))
                ],
              ))
        ],
      ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
