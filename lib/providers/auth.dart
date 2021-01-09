import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:CVAPP/model/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session/flutter_session.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  bool authFlag;
  var session = FlutterSession();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(User user) async {
    try {
      _token = user.email;
      _userId = user.email;

      //notifyListeners();
      //final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': user.email,
          'userId': user.email,
          'firstName': user.firstname,
          'lastName': user.lastname,
        },
      );
      // prefs.setString('userData', userData);

      session.set('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  /*  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  } */

  /*  Future<void> login(User usr) async {
    return _authenticate(usr.email, usr.firstname, 'verifyPassword');
  } */

  Future<void> login(User user) async {
    return _authenticate(user);
  }

  Future<bool> tryAutoLogin() async {
    /*   final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true; */

    dynamic extractedUserData = await FlutterSession().get("userData");

    //final prefs = await SharedPreferences.getInstance();
    if (extractedUserData['userId'] == null ||
        extractedUserData['userId'].toString().isEmpty) {
      return false;
    }
    //final extractedUserData = json.decode(extractedUserData['userId']);
    //final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    // if (expiryDate.isBefore(DateTime.now())) {
    // return false;
    //}
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    //_expiryDate = expiryDate;
    notifyListeners();
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

    final userData = json.encode(
      {
        'token': '',
        'userId': '',
        'firstName': '',
        'lastName': '',
      },
    );

    await session.set('userData', userData);

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
