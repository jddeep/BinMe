import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rrr/screens/homePage.dart';
import 'package:rrr/screens/mainPage.dart';
import 'package:rrr/utils/customRouteTransition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isNewUser = true;

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult _authResult =
          await _auth.signInWithCredential(credential);

      user = _authResult.user;

      _isNewUser = _authResult.additionalUserInfo.isNewUser;
      print("isnewUser: $_isNewUser");

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool _getIsSignedIn() {
    bool _isSignedIn = googleSignIn.currentUser != null;
    return _isSignedIn;
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
            // height: 40.0,
            // margin: EdgeInsets.all(8.0),
            child: new Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 35.0,
                ),
                new Text("Loading...", style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(microseconds: 0), () {
      //pop dialog
      // Navigator.pop(context,true);
      signInWithGoogle().then((user) {
        Navigator.of(context).pop(); //pop out the loading dialog.
        Navigator.push(
          context,
          CustomRouteTransition().createPageRoute(
            navigateTo: MainPage(
              selIndex: 0,
              user: user,
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/plantbg.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // flex: 8,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset("assets/images/phone.png"),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Log in to Get Started!",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold)
                                    .fontFamily,
                                color: Colors.black,
                                fontSize: 32),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            "",
                            style: TextStyle(
                                fontFamily: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold)
                                    .fontFamily,
                                color: Colors.black45,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          height: 32,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _onLoading,
                            child: Container(
//                      width: MediaQuery.of(context).size.width * 0.8,
//                    height: 50.0,
                              constraints:
                                  BoxConstraints(minHeight: 65, maxHeight: 65),
                              decoration: BoxDecoration(
                                color: Color(0xFF2B4F50),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // Container(
                                    //   height: 40.0,
                                    //   width: 80.0,
                                    Text("Sign In with",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.sourceSansPro()
                                                    .fontFamily,
                                            fontSize: 22.0,
                                            color: Colors.white)),
                                    Container(
                                      width: 12,
                                    ),
                                    Image.asset(
                                      "assets/images/google_sign_in_logo.png",
                                      height: 32.0,
                                      color: Colors.white,
                                      // ),
                                    ),
                                    //By Signing up, you agree to our Terms of Service and Privacy Policy
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
