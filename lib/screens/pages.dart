import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immence/models/route_arguments.dart';
import 'package:immence/screens/profilescreen.dart';
import 'package:immence/screens/userscreen.dart';

class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument? routeArgument;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key? key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  Widget currentPage = UserScreen();

  initState() {
    super.initState();
  }

  @override
  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          currentPage = UserScreen(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          currentPage = ProfileScreen(
            parentScaffoldKey: widget.scaffoldKey,
          );

          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: currentPage,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 3, blurRadius: 2),
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed, // Fixed

              selectedFontSize: 0,
              unselectedFontSize: 0,
              iconSize: 22,
              //    selectedItemColor: Colors.transparent,
              //    fixedColor: Colors.transparent,

              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedIconTheme:
                  IconThemeData(size: 22, color: Color(0xff0231C8)),
              unselectedItemColor: Color(0xff9F9F9F),
              currentIndex: widget.currentTab,
              onTap: (int i) {
                this._selectTab(i);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(Icons.person),
                      Text(
                        "Users",
                        style: GoogleFonts.manrope(
                            fontSize: 10, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      // new Image.asset(
                      //   'assets/images/home.png',
                      //   height: deviceHeight(context) * 0.04,
                      //   width: deviceWidth(context) * 0.05,
                      // ),
                      Icon(Icons.person_outline_sharp),

                      Text(
                        "Profile",
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ));
  }
}
