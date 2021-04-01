import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/sign_in_background.png'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.overlay),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Form(
                key: _loginController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      controller: _loginController.emailController,
                      decoration: _formInputDecoration(
                          label:
                              AppLocalizations.of(context).titleGeneralEmail),
                      style: TextStyle(color: Colors.white),
                      validator: _emailValidator,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _loginController.passwordController,
                      decoration: _formInputDecoration(
                          label: AppLocalizations.of(context)
                              .titleGeneralPassword),
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 50),
                    GetBuilder<LoginController>(builder: (state) {
                      if (state.isLoading.isTrue) {
                        return _disableLogin(context);
                      } else {
                        return _enableLogin(context);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _disableLogin(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white24),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
      ),
      child: Text(AppLocalizations.of(context).buttonLogin),
      onPressed: () => null,
    );
  }

  ElevatedButton _enableLogin(BuildContext context) {
    return ElevatedButton(
      child: Text(AppLocalizations.of(context).buttonLogin),
      onPressed: () {
        Get.focusScope.unfocus();
        return _attemptLogin();
      },
    );
  }

  InputDecoration _formInputDecoration({String label}) => InputDecoration(
        labelStyle: TextStyle(color: Colors.white30),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0)),
        fillColor: Colors.white24,
        filled: true,
        labelText: label,
      );

  String _emailValidator(String value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(Get.context).errorValidationEmailEmpty;
    }
    if (!EmailValidator.validate(value)) {
      return AppLocalizations.of(Get.context).errorValidationEmailInvalid;
    }
    return null;
  }

  void _attemptLogin() {
    _loginController.attemptLogin(
      onSuccess: () {
        final navigator = Get.find<AppNavigator>();
        navigator.popAndNavigateToHome();
      },
      onFailed: () {
        Get.snackbar(
          AppLocalizations.of(Get.context).titleGeneralError,
          AppLocalizations.of(Get.context).errorLoginFailed,
        );
      },
    );
  }
}
