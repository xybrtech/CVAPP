import 'package:COVAPP/constants/theme.dart';
import 'package:COVAPP/model/user.dart';

import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register(this.setUser);

  var _user = User(
    pK: null,
    firstname: '',
    lastname: '',
  );

  final Function setUser;

  final _form = GlobalKey<FormState>();

  final _lastnameFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();

  //bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
            builder: (context) => Form(
                key: _form,
                child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                          decoration: InputDecoration(labelText: 'First name'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your first name';
                            }

                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_lastnameFocusNode);
                          },
                          onSaved: (value) {
                            _user = User(
                              pK: _user.pK,
                              firstname: _user.firstname,
                              lastname: value,
                            );
                          }),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Last name'),
                        focusNode: _lastnameFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        onSaved: (value) {
                          _user = User(
                            pK: _user.pK,
                            firstname: _user.firstname,
                            lastname: value,
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        focusNode: _emailFocusNode,
                        /* validator: (value) => EmailValidator.validate(value)
                                ? null
                                : "Please enter a valid email",
                          ) */
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                        // child: Text('Vaccine Maker'),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: RaisedButton(
                              color: MaterialColors.primary,
                              onPressed: setUser(),
                              child: Text('Save',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Colors.white))))
                    ]))));
  }
}
