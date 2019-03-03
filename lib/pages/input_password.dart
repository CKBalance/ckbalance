import 'package:flutter/material.dart';
import 'package:ckbalance/resources/strings.dart';
import 'package:fluintl/fluintl.dart';
import 'package:ckbalance/views/password_field.dart';
import 'package:ckbalance/pages/input_repassword.dart';

class InputPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<InputPasswordPage> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  String _validatePassword(String value) {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return CustomLocalizations.of(context).getString(StringIds.errorEmptyPwd);
    if (passwordField.value.length < 8)
      return CustomLocalizations.of(context).getString(StringIds.errorLessPwd);
    return null;
  }

  _handlePwd() {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              InputRePasswordPage(passwordField.value)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            CustomLocalizations.of(context).getString(StringIds.inputPwdTitle)),
        leading: new IconButton(
          tooltip: 'back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            children: <Widget>[
              Text(
                CustomLocalizations.of(context)
                    .getString(StringIds.inputPwdTip),
                style: Theme.of(context).textTheme.body2,
              ),
              const SizedBox(
                height: 30,
              ),
              PasswordField(
                fieldKey: _passwordFieldKey,
                labelText: CustomLocalizations.of(context)
                    .getString(StringIds.inputPwdFieldLabel),
                helperText: CustomLocalizations.of(context)
                    .getString(StringIds.inputPwdFieldHelper),
                validator: _validatePassword,
                autofocus: true,
              ),
              const SizedBox(
                height: 30,
              ),
              RaisedButton(
                padding: const EdgeInsets.fromLTRB(60, 5, 60, 5),
                child: Text(
                  CustomLocalizations.of(context)
                      .getString(StringIds.nextButton),
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: _handlePwd,
              ),
            ],
          )),
    );
  }
}
