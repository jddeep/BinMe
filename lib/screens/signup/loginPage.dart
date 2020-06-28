import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    bool _isSignedIn =  googleSignIn.currentUser != null;
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(), //todo:  add background image
          Container(
            child: InkWell(
              onTap: _onLoading,
              child: Padding(
                padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1 ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(360.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   height: 40.0,
                        //   width: 80.0,
                        Image.asset(
                          "assets/images/google_sign_in_logo.png",
                          height: 40.0,
                          // ),
                        ),
                        SizedBox(
                          width: 28.0,
                        ),
                        Text("Sign In with Google",
                            style: TextStyle(fontSize: 22.0, color: Colors.white)),
                        //By Signing up, you agree to our Terms of Service and Privacy Policy
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
