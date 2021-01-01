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
        backgroundColor: MaterialColors.primary,
        // key: _scaffoldKey,
        drawer: SideMenu(currentPage: "Home"),
        body: Container(
            color: MaterialColors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: userVaccinehistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    //color: Colors.amber[colorCodes[index]],
                    child: Center(
                        child:
                            Text('Entry ${userVaccinehistory[index].doseNum}')),
                  );
                })));
  }
}
