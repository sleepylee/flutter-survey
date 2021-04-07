import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder(
          init: LoginController(),
          builder: (controller) => Center(
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
                        key: _formKey,
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
                              controller: controller.emailController,
                              decoration: _formInputDecoration(
                                  label: AppLocalizations.of(context)
                                      .titleGeneralEmail),
                              style: TextStyle(color: Colors.white),
                              validator: _emailValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: controller.passwordController,
                              decoration: _formInputDecoration(
                                  label: AppLocalizations.of(context)
                                      .titleGeneralPassword),
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 50),
                            GetX<LoginController>(builder: (state) {
                              return _loginButton(
                                  context: context, enable: !state.isLoading.value);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ));
  }

  ElevatedButton _loginButton({BuildContext context, bool enable = true}) {
    return ElevatedButton(
      style: enable
          ? ButtonStyle()
          : ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white24),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
      ),
      child: Text(AppLocalizations.of(context).buttonLogin),
      onPressed: () {
        if (enable && _formKey.currentState.validate()) {
          Get.focusScope.unfocus();
          return _attemptLogin();
        } else {
          return null;
        }
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
    if (!GetUtils.isEmail(value)) {
      return AppLocalizations.of(Get.context).errorValidationEmailInvalid;
    }
    return null;
  }

  void _attemptLogin() {
    Get.find<LoginController>().attemptLogin(
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
