import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/model/user.dart';

import 'package:COVAPP/providers/auth.dart';
import 'package:COVAPP/providers/vaccineitem.dart';
import 'package:COVAPP/providers/vaccineitems.dart';

import 'package:COVAPP/screens/history.dart';
import 'package:COVAPP/screens/register.dart';
import 'package:COVAPP/widgets/navbar.dart';
import 'package:COVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool isUserRegistered = false;

  List<bool> _isHighlighted = [true, false];

  bool _vaccineinfoEntered = false;

  String _firstName = '';

  String _lastName = '';

  bool _toHistoryPage = false;
  bool _toVaccineInfoPage = false;

/*   Vaccine _vaccine =
      new Vaccine(vaccineMaker: null, virus: null, vaccineItems: []); */

  List<VaccineItem> _vtList = [];

  void _saveForm(User usr) {
    print('Set state in save forms >>  $isUserRegistered');
    //final isValid = _form.currentState.validate();
    _firstName = usr.firstname;
    //SessionManager pref = new SessionManager();

    //pref.getUserData().then((result) {
    // If we need to rebuild the widget with the resulting data,
    // make sure to use `setState`

    //Object extractedUserData = json.decode(result);
    //print('Result' + result);
    //final extractedUserData = json.decode(result) as Map<String, Object>;

    setState(() {
      //_result = result;

      print('Set state in save forms 222 >>  $isUserRegistered');
      _firstName = usr.firstname;
      _lastName = usr.lastname;
      isUserRegistered = true;
      print('FirstName' + _firstName);
      print('FirstName' + _lastName);
    });
    //});
  }

  void _navigateHistory() {
    setState(() {
      _vaccineinfoEntered = false;
      _toVaccineInfoPage = false;
      _toHistoryPage = true;
      _isHighlighted[1] = true;
      _isHighlighted[0] = false;
    });
  }

  void _navigateVaccineInfo() {
    setState(() {
      _toVaccineInfoPage = true;
      _toHistoryPage = false;
      _vaccineinfoEntered = false;
      _isHighlighted[0] = true;
      _isHighlighted[1] = false;
    });
  }

  Future<void> _saveVaccineInfo(VaccineItem vac) {
    print('in save vaccine info' + _vaccineinfoEntered.toString());

    //_vtList = Provider.of<VaccineItems>(context, listen: true).items;

    setState(() {
      //isUserRegistered = false;

      print('Set state in save forms 222 >>  $isUserRegistered');
      _vtList.add(new VaccineItem(
          id: '',
          maker: vac.maker,
          doseNum: vac.doseNum,
          vaccinatedDate: vac.vaccinatedDate));

      //_vaccine = new Vaccine(
      //  vaccineMaker: vac.maker, virus: 'COVID', vaccineItems: _vtList);

      _toHistoryPage = false;
      _toVaccineInfoPage = false;
      _vaccineinfoEntered = true;
      _isHighlighted[1] = true;
      _isHighlighted[0] = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _vaccineinfoEntered = false;

    _toHistoryPage = false;

    _isHighlighted[0] = true;
    _isHighlighted[1] = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isHighlighted;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: VaccineItems(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => Scaffold(
            appBar: Navbar(
              bgColor: MaterialColors.primary,
              title: "Home",
              searchBar: false,
              categoryOne: "Vaccine info",
              categoryTwo: "Vaccine History",
              isHighlighted: _isHighlighted,
              navigateHistory: _navigateHistory,
              navigateVaccineInfo: _navigateVaccineInfo,
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
              child: auth.isAuth
                  ? _toVaccineInfoPage
                      ? CVForm(_saveVaccineInfo)
                      : _toHistoryPage
                          ? History()
                          : _vaccineinfoEntered
                              ? History()
                              : CVForm(_saveVaccineInfo)
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? _toVaccineInfoPage
                                  ? CVForm(_saveVaccineInfo)
                                  : _toHistoryPage
                                      ? History()
                                      : _vaccineinfoEntered
                                          ? History()
                                          : CVForm(_saveVaccineInfo)
                              : Register(_saveForm),
                    ),

              /* routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          } ,*/
            )),
      ),
    );
  }
}
