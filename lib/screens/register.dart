import 'package:CVAPP/constants/theme.dart';
import 'package:CVAPP/model/user.dart';
import 'package:CVAPP/providers/auth.dart';
import 'package:CVAPP/providers/users.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function setUser;

  Register(this.setUser);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _user = User(pK: null, firstname: '', lastname: '', email: '');

  final _form = GlobalKey<FormState>();

  final _lastnameFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();

  final _buttonFocusNode = FocusNode();

  void _submitData() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    Provider.of<Users>(context, listen: false).addUser(_user).then((value) =>
        Provider.of<Auth>(context, listen: false)
            .login(_user)
            .then((value) => widget.setUser(_user)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _lastnameFocusNode.dispose();
    _emailFocusNode.dispose();
    _buttonFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => Auth(),
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Builder(
                    builder: (context) => Form(
                        key: _form,
                        child: ListView(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'First name'),
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
                                        firstname: value,
                                        lastname: _user.lastname,
                                        email: _user.email);
                                  }),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Last name'),
                                focusNode: _lastnameFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_emailFocusNode);
                                },
                                onSaved: (value) {
                                  _user = User(
                                      pK: _user.pK,
                                      firstname: _user.firstname,
                                      lastname: value,
                                      email: _user.email);
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Email'),
                                focusNode: _emailFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your email';
                                  }

                                  if (!EmailValidator.validate(
                                      value, false, true)) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _user = User(
                                      pK: _user.pK,
                                      firstname: _user.firstname,
                                      lastname: _user.lastname,
                                      email: value);
                                },
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 50, 0, 20),
                                // child: Text('Vaccine Maker'),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      color: MaterialColors.primary,
                                      onPressed: _submitData,
                                      child: Text('Save',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                              color: Colors.white))))
                            ]))))));
  }
}
