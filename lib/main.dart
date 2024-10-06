import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro2/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.green,
          selectionColor: Color.fromARGB(255, 34, 199, 177),
          selectionHandleColor: Color.fromARGB(255, 34, 199, 177),
        ),
      ),
      title: "Project App",
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}
