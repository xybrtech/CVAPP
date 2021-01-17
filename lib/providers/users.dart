import 'dart:convert';

import 'package:CVAPP/constants/theme.dart';
import 'package:CVAPP/model/user.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  Future<String> addUser(User user) async {
    const url = Config.url;
    const key = Config.key;

    try {
      const url2 =
          Config.url + '?TableName=CVAPP&pk=chal@gmailcom&rtype=vaccine';

      http.Response res2 = await http.get(
        url2,
        headers: {"x-api-key": key, "CVAPPApi-Key": key},
      );
      if (res2.statusCode != 200) {
        print('User already exists');
      }

      http.Response res = await http.post(url,
          headers: {
            "x-api-key": key,
            "Authorization": "Api Token",
            "CVAPPApi-Key": key
          },
          body: json.encode({
            "TableName": "CVAPP",
            "Item": {
              "pk": user.email,
              "rtype": "User",
              "firstName": user.firstname.toLowerCase(),
              "lastName": user.lastname.toLowerCase()
            }
          }));

      if (res.statusCode != 200) {
        print('User already exists');
      }

      return res.statusCode.toString();
    } catch (_) {
      print('User alreay exists');
    }

    return null;

    //notifyListeners();
  }

  List<String> getVaccines() {
    const url = "https://covapp-e1142-default-rtdb.firebaseio.com/users.json";
  }

  //final newUser =
  //  new User(pK: 'Guduru', firstname: 'Pavan', lastname: 'Guduru');

  notifyListeners();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
