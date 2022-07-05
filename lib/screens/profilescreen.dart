import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immence/main.dart';
import 'package:immence/screens/loginscreen.dart';

import '../Responsive.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  const ProfileScreen({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String username = storage.read("name");
  final String email = storage.read("email");
  final String phone = storage.read("phone");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: deviceWidth(context) * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) * 0.03),
                  child: Container(
                    height: deviceHeight(context) * 0.16,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Ellipse 2.png"))),
                    child: Center(
                      child: Image.asset("assets/Subtract.png"),
                    ),
                  ),
                ),
                Text(
                  username,
                  style: GoogleFonts.manrope(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0231C8)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email",
                        style: GoogleFonts.manrope(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        email,
                        style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0231C8)),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone No.",
                        style: GoogleFonts.manrope(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        phone,
                        style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0231C8)),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Log out",
                        style: GoogleFonts.manrope(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          storage.erase();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Icon(
                          Icons.exit_to_app_rounded,
                          color: Color(0xff0231C8),
                        ),
                      )
                      // Text(
                      //   phone,
                      //   style: GoogleFonts.manrope(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w600,
                      //       color: Color(0xff0231C8)),
                      // ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
