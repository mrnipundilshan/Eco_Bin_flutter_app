import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScannerscore extends StatefulWidget {
  @override
  _QRScannerscoreState createState() => _QRScannerscoreState();
}

class _QRScannerscoreState extends State<QRScannerscore> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScoreUpdated = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null && !isScoreUpdated) {
        isScoreUpdated = true;
        _updateUserScore(result!.code!, context);
      }
    });
  }

  void _updateUserScore(String email, BuildContext context) async {
    print('Updating score for email: $email');
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1);

    final querySnapshot = await userRef.get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      await userDoc.reference.update({
        'score': FieldValue.increment(10),
      });

      print('Score updated successfully');

      if (mounted) {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 31, 160, 143),
              title: const Text(
                'Success',
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                'Score added',
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      print('No user found with email: $email');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.width * 0.9,
              width: size.width * 0.9,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
