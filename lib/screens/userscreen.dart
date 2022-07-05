import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Responsive.dart';

class UserScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  const UserScreen({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<DocumentChange<Map<String, dynamic>>> userdata = [];
  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((documentSnapshot) {
      setState(() {
        userdata = documentSnapshot.docChanges;
      });
    });
    super.initState();
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
                  padding: EdgeInsets.only(top: deviceHeight(context) * 0.05),
                  child: Text(
                    "Users",
                    style: GoogleFonts.manrope(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 1)
                              ],
                            ),
                            height: deviceHeight(context) * 0.1,
                            child: Row(
                              children: [
                                Container(
                                  height: deviceHeight(context) * 0.1,
                                  width: deviceWidth(context) * 0.15,
                                  child: Center(
                                    child: Text(
                                      userdata
                                          .elementAt(index)
                                          .doc["name"]
                                          .toString()
                                          .substring(0, 1),
                                      style: GoogleFonts.manrope(
                                          color: Color(0xff0231C8),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF2F5FC)),
                                ),

                                SizedBox(
                                  width: deviceWidth(context) * 0.04,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userdata.elementAt(index).doc["name"],
                                      style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      userdata.elementAt(index).doc["email"],
                                      style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                                // ListTile(

                                //   title: Text(
                                //       userdata.elementAt(index).doc["name"]),
                                //   subtitle: Text(
                                //       userdata.elementAt(index).doc["email"]),
                                // )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: deviceHeight(context) * 0.02,
                          );
                        },
                        itemCount: userdata.length))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
