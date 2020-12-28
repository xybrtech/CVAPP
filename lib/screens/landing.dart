import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/screens/form.dart';

import 'package:COVAPP/widgets/navbar.dart';
import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          bgColor: MaterialColors.primary,
          title: "Home",
          searchBar: false,
          categoryOne: "Vaccine info",
          categoryTwo: "Vaccine History",
        ),
        backgroundColor: MaterialColors.primary,
        // key: _scaffoldKey,
        drawer: SideMenu(currentPage: "Home"),
        body: Container(color: MaterialColors.white, child: CVForm()
            //History()
            ));
  }
}
