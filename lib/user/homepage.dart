import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/user/profile.dart';
import 'package:intl/intl.dart';

Future<int> getUserScoreByEmail() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String email = user.email!;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      return userDoc['score'];
    }
  }
  return 0;
}

// ignore: must_be_immutable
class homepage extends StatefulWidget {
  String email;
  String username;
  final Function(int) onItemTapped;

  homepage({
    super.key,
    required this.email,
    required this.username,
    required this.onItemTapped,
  });

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  DateTime? closestDate1;
  DateTime? closestDate2;

  Future<DocumentSnapshot> getLatestArticle() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('articles')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    return querySnapshot.docs.first;
  }

  @override
  void initState() {
    super.initState();
    _fetchClosestTwoDates();
  }

  Future<void> _fetchClosestTwoDates() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('selected_dates')
        .doc('user_selected_dates')
        .get();

    List<String> dateStrings = List<String>.from(snapshot['dates']);

    List<DateTime> dates =
        dateStrings.map((date) => DateTime.parse(date)).toList();

    dates.sort();

    DateTime now = DateTime.now();
    dates.sort(
        (a, b) => (a.difference(now).abs()).compareTo(b.difference(now).abs()));

    setState(() {
      closestDate1 = dates[0];
      closestDate2 = dates[1];
    });
  }

  Future<int> score = getUserScoreByEmail();
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMMM dd');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
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
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => showprodetails(
                                      email: widget.email,
                                      username: widget.username)));
                        },
                        icon: const Icon(Icons.supervised_user_circle),
                        iconSize: size.width * 0.15,
                        color: Colors.white,
                      ),
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
                      Text(
                        "\"\Clean Today, Green Tomorrow:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Easy Waste Management at Your Fingertips.\"\ ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onItemTapped(1);
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
                                "Pickup Schedule",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                              Icon(
                                Icons.delivery_dining_sharp,
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
                            widget.onItemTapped(2);
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
                                "Recycling Centers",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                ),
                              ),
                              Icon(
                                Icons.recycling,
                                color: Colors.white,
                                size: size.width * 0.1,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                          padding: const EdgeInsets.all(13),
                          width: size.width,
                          height: size.height * 0.1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 31, 160, 143),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('email',
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser!.email)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty) {
                                var userDoc = snapshot.data!.docs.first;
                                int score = userDoc['score'];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rewards",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "$score",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 0.05,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: size.width * 0.1,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return const Text('No score available');
                              }
                            },
                          )),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.all(13),
                        width: size.width,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 132, 255, 239),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Upcomming Pickup Dates",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 31, 160, 143),
                                  width: 2.0,
                                ),
                              ),
                              child: closestDate1 != null
                                  ? Text(
                                      'pick up waste | ${dateFormat.format(closestDate1!)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.05,
                                      ),
                                    )
                                  : Text(
                                      'Loading Closest Date 1...',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 31, 160, 143),
                                  width: 2.0,
                                ),
                              ),
                              child: closestDate2 != null
                                  ? Text(
                                      'pick up waste | ${dateFormat.format(closestDate2!)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.05,
                                      ),
                                    )
                                  : Text(
                                      'Loading Closest Date 1...',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Center(
                        child: Text(
                          "Educational tips",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: const Color.fromARGB(255, 31, 160, 143),
                            width: 2.0,
                          ),
                        ),
                        child: FutureBuilder<DocumentSnapshot>(
                          future: getLatestArticle(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                !snapshot.data!.exists) {
                              return const Center(
                                  child: Text('No articles found'));
                            } else {
                              var article =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      article['title'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.05,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(article['description'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.05,
                                        )),
                                    const SizedBox(height: 8),
                                    article['imageUrl'] != null
                                        ? Image.network(article['imageUrl'])
                                        : Container(),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.4,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onItemTapped(3);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            child: Text(
                              "See More >>",
                              style: TextStyle(
                                color: Colors.black,
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
