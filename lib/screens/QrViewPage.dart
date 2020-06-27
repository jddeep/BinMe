import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrViewPage extends StatefulWidget {
  @override
  _QrViewPageState createState() => _QrViewPageState();
}

class _QrViewPageState extends State<QrViewPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  // CustomRouteTransition routeTransition = CustomRouteTransition();

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
      print(qrText);
      // List<String> qrList = _verifyQrText(qrText); //todo: have to verify dustbin code.
      // print(qrList);
      Navigator.pop(context);
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            // overlay: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(3.0),
            //   side: BorderSide(color: Colors.deepPurple,width: 1.5)
            // ),
          ),
          Container(
            width: size.width * 0.55, //200.0,
            height: size.width * 0.55, //200.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
