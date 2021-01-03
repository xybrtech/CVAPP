import 'dart:convert';
import 'dart:async';

import 'package:COVAPP/model/http_exception.dart';
import 'package:COVAPP/model/user.dart';
import 'package:COVAPP/providers/session.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  bool authFlag;

  Future<bool> get isAuth async {
    print('isAuth 22>>>>>');
    return token != null;
  }

  Future<String> get token async {
    if (_token != null) {
      return _token;
    } else {
      SessionManager pref = new SessionManager();
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return null;
      } else {
        final extractedUserData =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        _token = extractedUserData['token'];
        return _token;
      }

      /* try {
        await pref.getUserData().then((result) {
          // If we need to rebuild the widget with the resulting data,
          // make sure to use `setState`

          //Object extractedUserData = json.decode(result);
          if (result != null) {
            print('Result' + result);
            final extractedUserData =
                json.decode(result) as Map<String, Object>;
            _token = extractedUserData['token'];

            
          }

          return _token;
        });
      } catch (Error) {} */
    }
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC13spCwP_f_SalxEbkB-wjedoF8iYENlQ';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      /* final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData); */
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(User user) async {
    //final prefs = await SharedPreferences.getInstance();

    print('User Object ' + user.firstname);
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      var today = new DateTime.now();
      var mins = today.add(new Duration(days: 2));

      final userData = json.encode(
        {
          'token': 'testToken',
          'userId': user.email,
          'firstName': user.firstname,
          'lastName': user.lastname,
          'expiryDate': mins.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      authFlag = true;
      _token = 'testrToken';
      _userId = user.email;
      _expiryDate = mins;
    } else {
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

      if (expiryDate.isBefore(DateTime.now())) {
        _token = null;
        _userId = null;
        prefs.remove('userData');
        prefs.clear();
        authFlag = false;
      }

      _token = extractedUserData['token'];
      _userId = extractedUserData['userId'];
      _expiryDate = expiryDate;
    }

    print('In logn method TOken ' + _token);

    print('In logn method User ID' + _userId);
    print('In logn method fName' + user.firstname);
    print('In logn method Lname' + user.lastname);

    print('In logn method Expiry Date' + _expiryDate.toString());

    //notifyListeners();

    //return _authenticate(email, password, 'verifyPassword');

    // return '';
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    // if (expiryDate.isBefore(DateTime.now())) {
    // return false;
    //}
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    //_expiryDate = expiryDate;
    // notifyListeners();
    //_autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
