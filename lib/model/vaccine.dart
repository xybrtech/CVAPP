import 'package:flutter/foundation.dart';

class VaccineItem {
  final String id;
  final String maker;
  final int doseNum;
  //final int quantity;
  //final double price;

  VaccineItem({
    @required this.id,
    @required this.maker,
    @required this.doseNum,
    // @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, VaccineItem> _items = {};

  Map<String, VaccineItem> get items {
    return {..._items};
  }
}
