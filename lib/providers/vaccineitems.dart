import 'dart:convert';
import 'dart:io';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

import 'package:COVAPP/constants/theme.dart';
import 'package:flutter/material.dart';

import 'vaccineitem.dart';

class VaccineItems with ChangeNotifier {
  // ignore: empty_constructor_bodies

  List<VaccineItem> _items = [];

  List<VaccineItem> get items {
    return [..._items];
  }

  Future<void> fetchAndSetHistory([bool filterByUser = false]) async {
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
      final List<VaccineItem> loadedProducts = [];

      extractedData.forEach((key, value) {
        if (key.isNotEmpty && key.contains('Items')) {
          value.toList().forEach((element) => loadedProducts.add(VaccineItem(
              pk: element["pk"],
              maker: element["maker"],
              doseNum: element["dose"],
              vaccinatedDate: element["vaccinedate"] != null
                  ? DateTime.tryParse(element["vaccinedate"])
                  : null,
              rtype: element["rtype"],
              vialNum: element["vialno"],
              virus: element["virus"])));
        }
      });

      _items = loadedProducts;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<String> addVaccineInfo(VaccineItem vac) async {
    const url = Config.url;
    const key = Config.key;

    try {
      http.Response res = await http.post(url,
          headers: {
            "x-api-key": key,
            "Authorization": "Api Token",
            "CVAPPApi-Key": key
          },
          body: json.encode({
            "TableName": "CVAPP",
            "Item": {
              "pk": vac.pk,
              "rtype": 'vaccine-' + vac.maker + '-' + vac.doseNum.toString(),
              "dose": vac.doseNum,
              "maker": vac.maker,
              "vialno": vac.vialNum,
              "virus": "COVID",
              "vaccinedate": vac.vaccinatedDate.toString()
            }
          }));

      if (res.statusCode != 200) {
        print('Error updating vaccine Info error code ' +
            res.statusCode.toString());
      }

      return res.statusCode.toString();
    } catch (e) {
      print('Error saving to DB' + e.toString());
    }

    return null;

    //notifyListeners();
  }
}
