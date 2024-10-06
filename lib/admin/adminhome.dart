import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/admin/qrscan.dart';
import 'package:pro2/login.dart';

// ignore: must_be_immutable
class adminhome extends StatefulWidget {
  String email;
  String username;
  final Function(int) onItemTapped;

  adminhome({
    super.key,
    required this.email,
    required this.username,
    required this.onItemTapped,
  });

  @override
  State<adminhome> createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(13),
                  width: size.width,
                  height: size.height * 0.14,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color.fromARGB(255, 31, 160, 143),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.supervised_user_circle,
                        size: size.width * 0.15,
                        color: Colors.white,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.username,
                              style: GoogleFonts.publicSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.04)),
                          Text(widget.email,
                              style: GoogleFonts.publicSans(
                                  fontSize: size.height * 0.02)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(13),
                  width: size.width,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.001),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: size.width * 0.44,
                            height: size.height * 0.2,
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onItemTapped(1);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 31, 160, 143)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.delivery_dining_sharp,
                                      color: Colors.white,
                                      size: size.width * 0.1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Add Pickup Schedule",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: size.width * 0.44,
                            height: size.height * 0.2,
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onItemTapped(2);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 31, 160, 143)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.recycling,
                                      color: Colors.white,
                                      size: size.width * 0.1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Add Recycling Centers",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onItemTapped(3);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  const Color.fromARGB(255, 31, 160, 143)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add Articles",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                              Icon(
                                Icons.wb_incandescent_sharp,
                                color: Colors.white,
                                size: size.width * 0.1,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRScannerscore()));
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  const Color.fromARGB(255, 31, 160, 143)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Scan QR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                              Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                                size: size.width * 0.1,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Center(
                        child: Container(
                          width: size.width * 0.4,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
