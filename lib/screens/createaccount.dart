import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immence/Responsive.dart';
import 'package:immence/screens/loginscreen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var checkboxvalue = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<DocumentReference<Object?>?> adduser(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    await users.add({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password
    }).then((documentReference) {
      Fluttertoast.showToast(msg: "User Created");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));

      // clearForm();
    }).catchError((e) {
      print("My Error is $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: deviceWidth(context) * 0.9,
              height: deviceHeight(context) * 0.97,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight(context) * 0.03),
                    child: Image.asset("assets/immence.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight(context) * 0.06),
                    child: Text(
                      "Create an account",
                      style: GoogleFonts.manrope(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight(context) * 0.02),
                    child: Text(
                      "Name",
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0231C8)),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.01),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter";
                              } else {
                                return null;
                              }
                            },
                            controller: namecontroller,
                            decoration: InputDecoration(
                                hintText: "Enter your name",
                                hintStyle: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.02),
                          child: Text(
                            "Email​ Address",
                            style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0231C8)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.01),
                          child: TextFormField(
                            controller: emailcontroller,
                            validator: ((value) {
                              if (value!.contains("@")) {
                                return null;
                              } else {
                                return "Enter Valid Email";
                              }
                            }),
                            decoration: InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.02),
                          child: Text(
                            "Phone Number",
                            style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0231C8)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.01),
                          child: TextFormField(
                            controller: phonecontroller,
                            validator: (value) {
                              if (value!.length == 10) {
                                return null;
                              } else {
                                return "10 Numbers required";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter your phone number",
                                hintStyle: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.02),
                          child: Text(
                            "Password",
                            style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0231C8)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight(context) * 0.01),
                          child: TextFormField(
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value!.length == 6) {
                                return null;
                              } else {
                                return "Password Must be 6 cherecters";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Please Enter Your Password",
                                hintStyle: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight(context) * 0.02),
                    child: Row(
                      children: [
                        Container(
                          height: deviceHeight(context) * 0.03,
                          width: deviceWidth(context) * 0.06,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              checkColor: Colors.black, // color of tick Mark
                              activeColor: Colors.white,

                              value: checkboxvalue,
                              onChanged: (value) {
                                setState(() {
                                  checkboxvalue = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) * 0.02,
                        ),
                        Text(
                          "Remember Me",
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        adduser(
                            name: namecontroller.text,
                            email: emailcontroller.text,
                            phone: phonecontroller.text,
                            password: passwordcontroller.text);
                      } else {}
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: deviceHeight(context) * 0.02),
                      child: Container(
                        height: deviceHeight(context) * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff0231C8)),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.manrope(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return LoginScreen();
                      })));
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: deviceHeight(context) * 0.04),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Already have an account ?",
                              style: GoogleFonts.manrope(
                                  color: Color(0xff999EA1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: "Login",
                              style: GoogleFonts.manrope(
                                  color: Color(0xff0231C8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600))
                        ])),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
