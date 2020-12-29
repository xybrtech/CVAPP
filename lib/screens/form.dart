import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/model/user.dart';
import 'package:COVAPP/providers/users.dart';
import 'package:COVAPP/widgets/vaccinemakerdrop.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CVForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<CVForm> {
  final _form = GlobalKey<FormState>();

  final _lastnameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  var _user = User(
    pK: null,
    firstname: '',
    lastname: '',
  );

  void _saveForm() {
    final isValid = _form.currentState.validate();
    Provider.of<Users>(context, listen: false).addUser();
    if (!isValid) {
      return;
    }
  }

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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //crossAxisAlignment: CrossAxisAlignment.stretch,

                          /* Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            // child: Text('Vaccine Maker'),
                          ) */
                          VaccineMaker(),
                          SimpleGroupedCheckbox<int>(
                            //key: checkboxKey,
                            itemsTitle: ["1st Dose", "2nd Dose"],
                            values: [1, 2],
                            activeColor: MaterialColors.primary,
                            checkFirstElement: false,
                            multiSelection: false,
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
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                          SimpleGroupedCheckbox<int>(
                              //key: checkboxKey,
                              itemsTitle: ["I Agree - Terms and Conditions"],
                              values: [1],
                              activeColor: MaterialColors.primary),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  color: MaterialColors.primary,
                                  onPressed: _saveForm,
                                  child: Text('Save',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          color: Colors.white)))),
                        ])))));
  }
}
