import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String RATING_TYPE_TEXT_AREA = "textarea";

class TextAreaRating extends StatelessWidget {
  final String textHint;

  TextAreaRating(this.textHint);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white.withOpacity(0.3)),
          hintText: textHint ?? AppLocalizations.of(context).hintTextArea,
          fillColor: Colors.white.withOpacity(0.3),
        ),
        maxLines: 8,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
