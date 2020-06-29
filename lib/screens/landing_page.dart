import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rrr/constants/constants.dart';
import 'package:rrr/ui_view/slider_layout_view.dart';
import 'package:rrr/widgets/custom_font.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  bool isSignedIn;
  FirebaseUser user;
  Future<FirebaseUser>  _getCurrentUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }
  @override
  void initState() {
    super.initState();
    _getCurrentUser().then((_user){
        setState(() {
          user = _user;
        });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
        child: SliderLayoutView(user: user),
      );
}
