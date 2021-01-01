import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  void addUser() {
    const url = "https://covapp-e1142-default-rtdb.firebaseio.com/users.json";

    http.post(url,
        body: json
            .encode({'firstname': 'Pavan', 'lastname': 'Guduru', 'id': '1'}));

    //final newUser =
    //  new User(pK: 'Guduru', firstname: 'Pavan', lastname: 'Guduru');

    notifyListeners();
  }

  List<String> getVaccines() {
    const url = "https://covapp-e1142-default-rtdb.firebaseio.com/users.json";
  }

  //final newUser =
  //  new User(pK: 'Guduru', firstname: 'Pavan', lastname: 'Guduru');

  notifyListeners();
}
