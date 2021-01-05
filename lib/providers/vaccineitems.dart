import 'dart:convert';

import 'package:COVAPP/constants/theme.dart';
import 'package:flutter/material.dart';

import 'vaccineitem.dart';
import 'package:http/http.dart' as http;

class VaccineItems with ChangeNotifier {
  // ignore: empty_constructor_bodies

  List<VaccineItem> vaccineItems = [
    VaccineItem(
        pk: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now()),
    VaccineItem(
        pk: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now()),
    VaccineItem(
        pk: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now()),
    VaccineItem(
        pk: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now())
  ];

  List<VaccineItem> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...vaccineItems];
  }

  Future<void> fetchAndSetHistory([bool filterByUser = false]) async {
    try {
//Fetch Data
      var queryParameters = {
        'TableName': 'one',
        'pk': 'two',
        'rtype': 'vaccine'
      };
      var uri = Uri.http(Config.url, '', queryParameters);

      // final uri = Uri.parse(Config.url).replace(query: queryParameters;
      var response = await http.get(uri, headers: {
        "x-api-key": Config.key,
        "Authorization": "Api Token",
        "CVAPPApi-Key": Config.key
      });

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<VaccineItem> vaccineItems = [];

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

/* Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://flutter-update.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  } */

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
              "rtype": "vaccine" + vac.vaccinatedDate.toString(),
              "dose": vac.doseNum,
              "maker": vac.maker,
              "vialno": vac.vialNum,
              "virus": "COVID"
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
}
