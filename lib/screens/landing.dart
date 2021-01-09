import 'dart:convert';

import 'package:CVAPP/constants/theme.dart';
import 'package:CVAPP/model/user.dart';
import 'package:CVAPP/providers/auth.dart';

import 'package:CVAPP/providers/authold.dart';
import 'package:CVAPP/providers/session.dart';
import 'package:CVAPP/providers/vaccineitem.dart';

import 'package:CVAPP/screens/form.dart';
import 'package:CVAPP/screens/history.dart';
import 'package:CVAPP/screens/register.dart';

import 'package:CVAPP/widgets/navbar.dart';
import 'package:CVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Landing2 extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing2> {
  bool isUserRegistered = false;
  bool _vaccineinfoEntered = false;

  String _firstName = '';
  String _lastName = '';
  //Vaccine _vaccine =
  //  new Vaccine(vaccineMaker: null, virus: null, vaccineItems: []);
  final List<VaccineItem> _vtList = [];

  void _saveForm(User usr) {
    print('Set state $isUserRegistered');
    //final isValid = _form.currentState.validate();
    _firstName = usr.firstname;
    SessionManager pref = new SessionManager();

    pref.getUserData().then((result) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`

      //Object extractedUserData = json.decode(result);
      print('Result' + result);
      final extractedUserData = json.decode(result) as Map<String, Object>;

      setState(() {
        //_result = result;

        _firstName = extractedUserData['firstName'];
        _lastName = extractedUserData['lastName'];

        print('FirstName' + _firstName);
        print('FirstName' + _lastName);
        isUserRegistered = true;
      });
    });
  }

  void _saveVaccineInfo(VaccineItem vac) {
    print('in save vaccine info' + isUserRegistered.toString());

    setState(() {
      //isUserRegistered = false;
      _vtList.add(new VaccineItem(
          pk: '',
          maker: vac.maker,
/* 
      _vaccine = new Vaccine(
          vaccineMaker: vac.maker, virus: 'COVID', vaccineItems: _vtList); */
          doseNum: vac.doseNum,
          vaccinatedDate: vac.vaccinatedDate));

      _vaccineinfoEntered = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    SessionManager pref = new SessionManager();

    print('Pavan init called');
    pref.getUserData().then((result) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('In build Landing Page>>' + isUserRegistered.toString());
    return ChangeNotifierProvider(
        create: (ctx) => Auth(),
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => Scaffold(
                appBar: Navbar(
                  bgColor: MaterialColors.primary,
                  title: "Home",
                  searchBar: false,
                  categoryOne: "Vaccine info",
                  categoryTwo: "Vaccine History",
                ),
                backgroundColor: MaterialColors.primary,
                // key: _scaffoldKey,
                drawer: SideMenu(
                  currentPage: "Home",
                  firstName: _firstName,
                  lastName: _lastName,
                ),
                body: Container(
                    color: MaterialColors.white,
                    child: FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? (_vaccineinfoEntered
                                    ? History()
                                    : CVForm(_saveVaccineInfo, ""))
                                : Register(_saveForm))
                    //History()

                    ))));
  }
}
