import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:van_bill_generation/apicalls/api.dart';
import 'package:van_bill_generation/screens/signUpscreen.dart';

import '../widgets/bottomNavigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.1,
            0.8,
          ],
          colors: [
            Color.fromRGBO(91, 158, 239, 1),
            Color.fromRGBO(53, 133, 228, 1),
          ],
        )),
        child: Stack(
          alignment: Alignment.center,
          //
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Lottie.asset(
                      "asstes/94128-welcome.json",
                    ),
                  ),
                  // Text(
                  //   "Login",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: 25),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please ente the User Name";
                        }
                      },
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          hintText: "User Name",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: isPasswordVisible,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please ente the Password";
                        }
                      },
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          suffixIcon: isPasswordVisible == true
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                      onTap: () async {
                        final valid = formKey.currentState!.validate();
                        if (!valid) {
                          return;
                        } else {
                          ///------------------------------ api call
                          var id = await Apis().loginApicall(
                              nameController.text, passwordController.text);
                          print(id);
                          if (id != "failed") {
                            SharedPreferences pref =await SharedPreferences.getInstance();
                            pref.setString("id", id.toString());

                            Navigator.of(context).pushAndRemoveUntil(
                              // the new route
                              MaterialPageRoute(
                                builder: (BuildContext context) => BottomNavigationBarPage(),
                              ),

                                  (Route route) => false,
                            );

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         BottomNavigationBarPage()));
                          } else {
                            final SnackBar _snackBar = SnackBar(
                              content: const Text(
                                  'Username or Password was incorrect'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 190,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(4, 4),
                                spreadRadius: 1,
                                blurRadius: 2,
                              )
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(53, 133, 228, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SignUpPage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
