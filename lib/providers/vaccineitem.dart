import 'package:flutter/material.dart';

class VaccineItem with ChangeNotifier {
  final String pk;
  final String maker;
  final int doseNum;
  final DateTime vaccinatedDate;
  final String rtype;
  final String vialNum;
  final String virus;

  //final int quantity;
  //final double price;

  VaccineItem(
      {@required this.pk,
      @required this.maker,
      @required this.doseNum,
      @required this.vaccinatedDate,
      @required this.rtype,
      @required this.vialNum,
      @required this.virus

      // @required this.price,
      });
}
