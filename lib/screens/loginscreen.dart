import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immence/Responsive.dart';
import 'package:immence/main.dart';
import 'package:immence/screens/createaccount.dart';
import 'package:immence/screens/pages.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var checkboxvalue = false;

  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  Future<dynamic> login(
      {required String user, required String password}) async {
    var result = FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: user)
        .where("password", isEqualTo: password)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.docChanges.length == 0) {
        Fluttertoast.showToast(msg: "User Not Found");
      } else {
        var username = documentSnapshot.docChanges[0].doc.data()!["name"];
        var email = documentSnapshot.docChanges[0].doc.data()!["email"];
        var phone = documentSnapshot.docChanges[0].doc.data()!["phone"];
        storage.write("name", username);
        storage.write("email", email);
        storage.write("phone", phone);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return PagesWidget();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: deviceWidth(context) * 0.9,
            child: Column(
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
                    "Hi, Wecome Back! 👋",
                    style: GoogleFonts.manrope(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) * 0.03),
                  child: Text(
                    "Email",
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
                        padding:
                            EdgeInsets.only(top: deviceHeight(context) * 0.01),
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
                              hintText: "Enter Email",
                              hintStyle: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: deviceHeight(context) * 0.025),
                        child: Text(
                          "Password",
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff0231C8)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: deviceHeight(context) * 0.01),
                        child: AppTextField(
                          validator: (value) {
                            if (value!.length == 6) {
                              return null;
                            } else {
                              return "Password Must be 6 cherecters";
                            }
                          },
                          controller: passwordcontroller,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: InputDecoration(
                            hintText: "Please Enter Your Password",
                            hintStyle: GoogleFonts.manrope(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIconColor: Colors.black,
                          ),
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
                      login(
                          user: emailcontroller.text,
                          password: passwordcontroller.text);
                    } else {}
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: deviceHeight(context) * 0.02),
                    child: Container(
                      height: deviceHeight(context) * 0.06,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff0231C8)),
                      child: Center(
                        child: Text(
                          "Login",
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
                      return CreateAccountScreen();
                    })));
                  },
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: deviceHeight(context) * 0.04),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Don’t have an account ? ",
                            style: GoogleFonts.manrope(
                                color: Color(0xff999EA1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: "Sign Up",
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
    );
  }
}
