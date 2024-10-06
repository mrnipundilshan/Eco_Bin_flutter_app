import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/login.dart';
import 'package:pro2/services/auth.dart';

class register extends StatefulWidget {
  register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
              color: Color.fromARGB(255, 31, 160, 143),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.25),
                Text(
                  "Hello User",
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.width * 0.08,
                  ),
                ),
                Text(
                  "Welcome To ECOBIN",
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: size.width * 0.08,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  height: size.height * 0.5,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Register",
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size.width * 0.08,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextField(
                          maxLength: 30,
                          controller: usernamecontroller,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.02),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 31, 160, 143),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 10, style: BorderStyle.solid)),
                            counterText: '',
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        TextField(
                          maxLength: 40,
                          controller: emailcontroller,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.02),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 31, 160, 143),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 10, style: BorderStyle.solid)),
                            counterText: '',
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        TextField(
                          maxLength: 20,
                          controller: passwordcontroller,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.02),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 31, 160, 143),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 10, style: BorderStyle.solid)),
                            counterText: '',
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          width: size.width * 0.95,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () async {
                              await AuthServices.signupUser(
                                  emailcontroller.text,
                                  passwordcontroller.text,
                                  usernamecontroller.text,
                                  context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            child: Text(
                              "REGISTER",
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: size.width * 0.06,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.04,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
