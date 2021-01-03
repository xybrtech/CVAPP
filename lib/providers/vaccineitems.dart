import 'package:flutter/material.dart';

import 'vaccineitem.dart';

class VaccineItems with ChangeNotifier {
  // ignore: empty_constructor_bodies

  List<VaccineItem> vaccineItems = [
    VaccineItem(
        id: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now()),
    VaccineItem(
        id: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now()),
    VaccineItem(
        id: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now()),
    VaccineItem(
        id: 'p1', maker: 'Pfizer', doseNum: 2, vaccinatedDate: DateTime.now())
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

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
