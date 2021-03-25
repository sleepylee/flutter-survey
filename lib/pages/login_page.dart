import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/sign_in_background.png')),
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 150.0),
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                      const SizedBox(height: 100),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white30),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12.0)),
                            fillColor: Colors.white24,
                            filled: true,
                            labelText:
                                AppLocalizations.of(context).titleGeneralEmail),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)
                                .errorValidationEmailEmpty;
                          } else if (!EmailValidator.validate(value)) {
                            return AppLocalizations.of(context)
                                .errorValidationEmailInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white30),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12.0)),
                            fillColor: Colors.white24,
                            filled: true,
                            labelText: AppLocalizations.of(context)
                                .titleGeneralPassword),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                          child: Text(AppLocalizations.of(context).buttonLogin),
                          onPressed: () {})
                    ],
                  ),
                ))),
      ),
    );
  }
}
