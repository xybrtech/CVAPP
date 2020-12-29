import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/screens/form.dart';
import 'package:COVAPP/screens/register.dart';

import 'package:COVAPP/widgets/navbar.dart';
import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool isUserRegistered = true;

  final _form = GlobalKey<FormState>();

  void _saveForm() {
    //final isValid = _form.currentState.validate();
    //Provider.of<Users>(context, listen: false).addUser();

    /* setState(() {
      isUserRegistered = false;

      print('Set state $isUserRegistered');
    }); */

    //if (!isValid) {
    //return;
    //}
  }

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
        body: Container(
            color: MaterialColors.white,
            child: isUserRegistered ? CVForm() : Register(_saveForm)

            //History()
            ));
  }
}
