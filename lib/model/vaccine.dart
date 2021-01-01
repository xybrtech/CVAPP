import 'package:flutter/foundation.dart';

class VaccineItem {
  final String id;
  final String maker;
  final int doseNum;
  final DateTime vaccinatedDate;

  //final int quantity;
  //final double price;

  VaccineItem(
      {@required this.id,
      @required this.maker,
      @required this.doseNum,
      @required this.vaccinatedDate

      // @required this.price,
      });
}

class Vaccine {
  final String vaccineMaker;
  final String virus;
  final List<VaccineItem> vaccineItems;

  Vaccine({
    @required this.vaccineMaker,
    @required this.virus,
    @required this.vaccineItems,
  });
}

class Cart with ChangeNotifier {
  Map<String, VaccineItem> _items = {};

  Map<String, VaccineItem> get items {
    return {..._items};
  }
}
