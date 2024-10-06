import 'package:flutter/material.dart';
import 'package:pro2/login.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class showprodetails extends StatelessWidget {
  String email;
  String username;

  showprodetails({
    super.key,
    required this.email,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                email,
                style:
                    TextStyle(color: Colors.black, fontSize: size.width * 0.08),
              ),
              Text(
                username,
                style:
                    TextStyle(color: Colors.black, fontSize: size.width * 0.06),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              QrImageView(
                data: email,
                version: QrVersions.auto,
                size: size.width * 0.6,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
