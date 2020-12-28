import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class VaccineMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            items: [
              "Pfizer",
              "Moderna",
              "Glaxosmithkline (Disabled)",
              "Merck (Disabled)",
              'AstraZeneca (Disabled)',
              'Novavax (Disabled)'
            ],
            label: "Vaccine Maker",
            hint: "Pharma Company",
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: "Pfizer"));
  }
}
