import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 50.0),
                Text(
                  'Jaideep Prasad',
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
                        'Points',
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
                      title: Text('Cardboard'),
                      leading: Icon(Icons.donut_small),
                    ),
                    ListTile(
                      title: Text('Plastic'),
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
                        onTap: () {},
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
