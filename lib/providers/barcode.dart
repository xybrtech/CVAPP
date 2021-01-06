import 'dart:convert';

import 'package:COVAPP/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class BarCodeData with ChangeNotifier {
  //final JSON data;

  //final int quantity;
  //final double price;
  /*  VaccineItem(
      {@required this.id,
      @required this.maker,
      @required this.doseNum,
      @required this.vaccinatedDate

      // @required this.price,
      }); */

  Future<void> fetchBarCodeData([bool filterByUser = false]) async {
    try {
      //Fetch Data

      dynamic extractedUserData = await FlutterSession().get("userData");

      String emailId = extractedUserData['userId'];

      var url =
          Config.url + '?TableName=CVAPP&pk=' + emailId + '&rtype=vaccine';
      const key = Config.key;

      var res = await http.get(url, headers: {
        "x-api-key": Config.key,
        "Authorization": "Api Token",
        "CVAPPApi-Key": Config.key
      });

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      // final List<VaccineItem> loadedProducts = [];

      //TODO populate bar code info

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class BarCode {
  final String firstName;
  final String LastName;
  final String virus;
  final String maker;
  final String Dose;
  final String vial;

  //final int quantity;
  //final double price;

  BarCode(
      {@required this.firstName,
      @required this.LastName,
      @required this.virus,
      @required this.maker,
      @required this.Dose,
      @required this.vial});
}
