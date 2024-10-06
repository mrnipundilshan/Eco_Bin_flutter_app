import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/register.dart';
import 'package:pro2/services/auth.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: size.width,
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
                      color: Colors.black,
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.bold,
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
                            "Login",
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: size.width * 0.08,
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
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
                              hintStyle: const TextStyle(color: Colors.black),
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
                              onPressed: () {
                                AuthServices.signinUser(usernamecontroller.text,
                                    passwordcontroller.text, context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow),
                              child: Text(
                                "LOGIN",
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
                                        builder: (context) => register()));
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 0.04,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Register',
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
      ),
    );
  }
}
