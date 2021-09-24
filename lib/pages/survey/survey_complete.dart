import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/gen/assets.gen.dart';

const int DELAY_BEFORE_EXEC_IN_SEC = 2;

class SurveyComplete extends StatelessWidget {
  final Function onComplete;

  const SurveyComplete({Key key, this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: DELAY_BEFORE_EXEC_IN_SEC), () {
      onComplete.call();
    });
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.images.confetti,
            width: 200,
            height: 200,
            repeat: false,
            fit: BoxFit.fill,
          ),
          Text(
            AppLocalizations.of(context).messageCompleteSurvey,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
