import 'package:CVAPP/constants/theme.dart';
import 'package:CVAPP/model/user.dart';

import 'package:CVAPP/providers/auth.dart';
import 'package:CVAPP/providers/vaccineitem.dart';
import 'package:CVAPP/providers/vaccineitems.dart';

import 'package:CVAPP/screens/history.dart';
import 'package:CVAPP/screens/register.dart';
import 'package:CVAPP/widgets/navbar.dart';
import 'package:CVAPP/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import './barcode.dart';
import '../providers/string_extension.dart';

import 'form.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool isUserRegistered = false;

  List<bool> _isHighlighted = [true, false];

  bool _vaccineinfoEntered = false;

  String _currentPage;

  String _firstName = '';

  String _lastName = '';

  bool _toHistoryPage = false;
  bool _toVaccineInfoPage = false;
  bool _toBarCodePage = false;

  String _emailId;

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

      _emailId = usr.email;
      _firstName = usr.firstname;
      _lastName = usr.lastname;
      isUserRegistered = true;
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
      _toBarCodePage = false;

      _currentPage = 'Vaccine History';
    });
  }

  void _navigateVaccineInfo() {
    setState(() {
      _toVaccineInfoPage = true;
      _toHistoryPage = false;
      _vaccineinfoEntered = false;
      _isHighlighted[0] = true;
      _isHighlighted[1] = false;
      _toBarCodePage = false;

      _currentPage = 'VaccineInfo';
    });
  }

  void _navigateBarCode() {
    print('Navigate barcode');
    setState(() {
      _toVaccineInfoPage = false;
      _toHistoryPage = false;
      _vaccineinfoEntered = false;
      _isHighlighted[0] = false;
      _isHighlighted[1] = false;
      _toBarCodePage = true;

      _currentPage = 'BarCode';
    });
  }

  Future<void> _saveVaccineInfo(VaccineItem vac) {
    print('in save vaccine info' + _vaccineinfoEntered.toString());

    //_vtList = Provider.of<VaccineItems>(context, listen: true).items;

    Provider.of<VaccineItems>(context, listen: false)
        .addVaccineInfo(vac)
        .then((value) => setState(() {
              //isUserRegistered = false;

              print('Set state in save forms 222 >>  $isUserRegistered');
              _vtList.add(new VaccineItem(
                  pk: _emailId,
                  maker: vac.maker,
                  doseNum: vac.doseNum,
                  vaccinatedDate: vac.vaccinatedDate));

              //_vaccine = new Vaccine(
              //  vaccineMaker: vac.maker, virus: 'COVID', vaccineItems: _vtList);
              _toBarCodePage = true;
              _toHistoryPage = false;
              _toVaccineInfoPage = false;
              _vaccineinfoEntered = true;

              _isHighlighted[1] = false;
              _isHighlighted[0] = false;
            }));
  }

  @override
  void initState() {
    // TODO: implement initState

    FlutterSession().get("userData").then((extractedUserData) => {
          setState(() {
            _firstName = extractedUserData['firstName'];
            _lastName = extractedUserData['lastName'];
            _emailId = extractedUserData['userId'];
          })
        });

    _vaccineinfoEntered = false;

    _toHistoryPage = false;

    _isHighlighted[0] = true;
    _isHighlighted[1] = false;
    _currentPage = 'Home';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isHighlighted;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => Scaffold(
            appBar: Navbar(
              bgColor: MaterialColors.primary,
              title: "CVAPP",
              searchBar: false,
              categoryOne: "Vaccine info",
              categoryTwo: "History",
              isHighlighted: _isHighlighted,
              navigateHistory: _navigateHistory,
              navigateVaccineInfo: _navigateVaccineInfo,
            ),
            backgroundColor: MaterialColors.primary,
            // key: _scaffoldKey,
            drawer: SideMenu(
                currentPage: _currentPage,
                firstName: _firstName.capitalize(),
                lastName: _lastName.capitalize(),
                navigateBarCode: _navigateBarCode),
            body: Container(
              color: MaterialColors.white,
              child: auth.isAuth
                  ? _toBarCodePage
                      ? Barcode()
                      : _toVaccineInfoPage
                          ? CVForm(_saveVaccineInfo, _emailId)
                          : _toHistoryPage
                              ? History()
                              : _vaccineinfoEntered
                                  ? History()
                                  : CVForm(_saveVaccineInfo, _emailId)
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) => authResultSnapshot
                                  .connectionState ==
                              ConnectionState.done
                          ? authResultSnapshot.hasData &&
                                  authResultSnapshot.data
                              ? _toBarCodePage
                                  ? Barcode()
                                  : _toVaccineInfoPage
                                      ? CVForm(_saveVaccineInfo, _emailId)
                                      : _toHistoryPage
                                          ? History()
                                          : _vaccineinfoEntered
                                              ? History()
                                              : CVForm(
                                                  _saveVaccineInfo, _emailId)
                              : Register(_saveForm)
                          : CircularProgressIndicator()),

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
