import 'package:flutter/material.dart';

class VaccineItem with ChangeNotifier {
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
