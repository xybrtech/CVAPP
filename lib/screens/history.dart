import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/model/vaccine.dart';
import 'package:COVAPP/widgets/navbar.dart';
import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final List<VaccineItem> userVaccinehistory;

  History(this.userVaccinehistory);

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
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: ListView(
              children: [
                Text("Darryl Brown",
                    style:
                        TextStyle(color: MaterialColors.primary, fontSize: 21)),
                Text("Test User",
                    style:
                        TextStyle(color: MaterialColors.primary, fontSize: 21))
              ],
            )));
  }
}
