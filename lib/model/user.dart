import 'package:flutter/foundation.dart';

/*
{
  "_PK": "Ram",
  "firstname": "Ram",
  "lastname": "Pallikonda",
  "Vaccine": [
    {
      "JhonsonandJohson": {
        "history": [
          {
            "Dose": "1",
            "vaccinateddate": "Jan120201"
          },
          {
            "Dose": "1",
            "vaccinateddate": "Jan120201"
          }
        ],
        "virus": "COVID"
      }
    },
    {
      "Pfizer": {
        "history": [
          {
            "Dose": "1",
            "vaccinateddate": "Jan120201"
          },
          {
            "Dose": "1",
            "vaccinateddate": "Jan120201"
          }
        ],
        "virus": "Influenza"
      }
    }
  ],
  "vaccineM": "Moderna"
}

*/

class User with ChangeNotifier {
  final String pK;
  final String firstname;
  final String lastname;
  //final List<VaccineItem> vaccines;
  //final DateTime dateTime;

  // final double price;
  //final String imageUrl;
  //bool isFavorite;

  User({
    @required this.pK,
    @required this.firstname,
    @required this.lastname,
    //@required this.price,
    //@required this.imageUrl,
    //this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    //isFavorite = !isFavorite;
    notifyListeners();
  }
}
