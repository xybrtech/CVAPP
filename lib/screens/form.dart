import 'dart:convert';

import 'package:CVAPP/constants/theme.dart';
import 'package:CVAPP/model/user.dart';
import 'package:CVAPP/providers/vaccineitem.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CVForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();

  final Function _saveVaccine;
  final String _userID;

  CVForm(this._saveVaccine, this._userID);
}

class _FormState extends State<CVForm> {
  final _form = GlobalKey<FormState>();
  List<String> _vaccineList = ['-Select-'];

  final _lastnameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  DateTime _selectedDate;

  bool agree = false;

  var _user = User(pK: null, firstname: '', lastname: '', email: '');

  var _vaccine = VaccineItem(
      vaccinatedDate: DateTime.now(), maker: 'Pfizer', doseNum: 0, pk: '');

  void _saveForm() {
    final isValid = _form.currentState.validate();

    widget._saveVaccine(_vaccine);
    if (!isValid) {
      return;
    }
  }

  Future<dynamic> getVaccineList() async {
    var url = Config.url + '?TableName=CVAPP&pk=vaccinelist&rtype=dropdown';
    const key = Config.key;

    var res = await http.get(url, headers: {
      "x-api-key": Config.key,
      "Authorization": "Api Token",
      "CVAPPApi-Key": Config.key
    });

    List<String> loadedProducts = [];

    final extractedData = json.decode(res.body) as Map<String, dynamic>;

    List items = extractedData['Items'];

    items.toList().forEach((element) => loadedProducts.add(element['name']));
    return loadedProducts;
  }

  @override
  void initState() {
    //_imageUrlFocusNode.addListener(_updateImageUrl);
    this.getVaccineList().then((value) => setState(() {
          _vaccineList = value as List<String>;
        }));

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
                    child: ListView(

                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //crossAxisAlignment: CrossAxisAlignment.stretch,

                          /* Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            // child: Text('Vaccine Maker'),
                          ) */
                          DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,

                            showSelectedItem: false,
                            items: _vaccineList,
                            label: "Vaccine Maker",
                            hint: "Pharma Company",

                            popupItemDisabled: (String s) =>
                                s.contains('Disabled'),
                            onChanged: (value) {
                              _vaccine = VaccineItem(
                                  pk: widget._userID,
                                  maker: value,
                                  doseNum: _vaccine.doseNum,
                                  vialNum: _vaccine.vialNum,
                                  vaccinatedDate: _vaccine.vaccinatedDate);
                            },
                            //selectedItem: "Pfizer",
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
                                  pk: widget._userID,
                                  maker: _vaccine.maker,
                                  doseNum: value,
                                  vialNum: _vaccine.vialNum,
                                  vaccinatedDate: _vaccine.vaccinatedDate);
                            },
                          ),

                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Vaccine#',
                              labelText: 'Vial #',
                            ),
                            onSaved: (String value) {
                              _vaccine = VaccineItem(
                                  pk: widget._userID,
                                  maker: _vaccine.maker,
                                  doseNum: _vaccine.doseNum,
                                  vialNum: value,
                                  vaccinatedDate: _vaccine.vaccinatedDate);
                            },
                          ),

                          SizedBox(height: 10),
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
                                  pk: widget._userID,
                                  maker: _vaccine.maker,
                                  doseNum: _vaccine.doseNum,
                                  vialNum: _vaccine.vialNum,
                                  vaccinatedDate: DateTime.parse(val));
                            },
                          ),

                          SizedBox(height: 30),

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
                                'I have read and accept ',
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // do what you need to do when "Click here" gets clicked
                                    return showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('TERMS AND CONDITIONS'),
                                        content: Text(
                                          'By agreeing to the terms and conditions, the “User” is verifying that the information provided is correct and accurate.',
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Disagree'),
                                            onPressed: () {
                                              setState(() {
                                                agree = false;
                                              });
                                              Navigator.of(ctx).pop(false);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Agree'),
                                            onPressed: () {
                                              setState(() {
                                                agree = true;
                                              });
                                              Navigator.of(ctx).pop(true);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text("terms and conditions",
                                      style: new TextStyle(
                                          color: Colors.blue,
                                          decoration:
                                              TextDecoration.underline))),
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
                        ])))));
  }
}
