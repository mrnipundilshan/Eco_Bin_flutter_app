import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class calender extends StatefulWidget {
  calender({super.key});

  @override
  State<calender> createState() => _calenderState();
}

class _calenderState extends State<calender> {
  Map<DateTime, List> _events = {};
  List<DateTime> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    _fetchDatesFromFirestore();
  }

  Future<void> _fetchDatesFromFirestore() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('selected_dates')
        .doc('user_selected_dates')
        .get();

    if (snapshot.exists) {
      List<dynamic> dateStrings = snapshot['dates'];
      setState(() {
        _selectedDates =
            dateStrings.map((date) => DateTime.parse(date)).toList();
        _events = {
          for (var date in _selectedDates) date: ['Selected Date']
        };
      });
    }
  }

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pickup Schedule",
                          style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.04)),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(121, 1, 78, 33),
                      borderRadius: BorderRadius.circular(13)),
                  child: IgnorePointer(
                    ignoring: true,
                    child: CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          selectedDayHighlightColor:
                              const Color.fromARGB(255, 39, 206, 184),
                          weekdayLabelTextStyle:
                              const TextStyle(color: Colors.black),
                          dayTextStyle: const TextStyle(color: Colors.white),
                          selectedDayTextStyle:
                              const TextStyle(color: Colors.black),
                          monthTextStyle: const TextStyle(color: Colors.black),
                          yearTextStyle: const TextStyle(color: Colors.black),
                          calendarType: CalendarDatePicker2Type.multi,
                          daySplashColor: Colors.transparent,
                        ),
                        value: _selectedDates,
                        onValueChanged: (dates) {}),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
