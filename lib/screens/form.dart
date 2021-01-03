import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/model/user.dart';
import 'package:COVAPP/providers/vaccineitem.dart';

import '../providers/vaccineitems.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CVForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();

  final Function _saveVaccine;

  CVForm(this._saveVaccine);
}

class _FormState extends State<CVForm> {
  final _form = GlobalKey<FormState>();

  final _lastnameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  DateTime _selectedDate;

  bool agree = false;

  var _user = User(pK: null, firstname: '', lastname: '', email: '');

  var _vaccine = VaccineItem(
      vaccinatedDate: DateTime.now(), maker: '', doseNum: 0, id: '');

  void _saveForm() {
    final isValid = _form.currentState.validate();

    //Provider.of<Users>(context, listen: false).addUser();

    print("DoseNum " + _vaccine.doseNum.toString());
    print("Maker " + _vaccine.maker);
    print("DoseNum " + _vaccine.id);
    print("Date " + _vaccine.vaccinatedDate.toString());

    widget._saveVaccine(_vaccine);

    if (!isValid) {
      return;
    }
  }
/* 
  void _addNewVaccine(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Vaccine(
      vaccineMaker: txTitle,
       virus: 'COVID',
      : chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  } */

  @override
  void initState() {
    //_imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _form,
                    child: Expanded(
                        child: ListView(

                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          //crossAxisAlignment: CrossAxisAlignment.stretch,

                          /* Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            // child: Text('Vaccine Maker'),
                          ) */
                          DropdownSearch<String>(
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
                            onChanged: (value) {
                              _vaccine = VaccineItem(
                                  id: _vaccine.id,
                                  maker: value,
                                  doseNum: _vaccine.doseNum,
                                  vaccinatedDate: _vaccine.vaccinatedDate);
                            },
                            selectedItem: "Pfizer",
                          ),

                          SimpleGroupedCheckbox<int>(
                            //key: checkboxKey,
                            itemsTitle: ["1st Dose", "2nd Dose"],
                            values: [1, 2],
                            activeColor: MaterialColors.primary,
                            checkFirstElement: false,
                            multiSelection: false,
                            onItemSelected: (value) {
                              _vaccine = VaccineItem(
                                  id: _vaccine.id,
                                  maker: _vaccine.maker,
                                  doseNum: value,
                                  vaccinatedDate: _vaccine.vaccinatedDate);
                            },
                          ),
                          DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Vaccine Date',
                            timeLabelText: "Hour",
                            selectableDayPredicate: (date) {
                              // Disable weekend days to select from the calendar
                              if (date.weekday == 0 || date.weekday == 0) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (val) {
                              _vaccine = VaccineItem(
                                  id: _vaccine.id,
                                  maker: _vaccine.maker,
                                  doseNum: _vaccine.doseNum,
                                  vaccinatedDate: DateTime.parse(val));
                            },
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value;
                                    });
                                  }),
                              Text(
                                'I have read and accept terms and conditions',
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),

                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  color: MaterialColors.primary,
                                  onPressed: agree ? _saveForm : null,
                                  child: Text('Save',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          color: Colors.white)))),
                        ]))))));
  }
}
