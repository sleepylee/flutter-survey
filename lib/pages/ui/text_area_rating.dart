import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String RATING_TYPE_TEXT_AREA = "textarea";
const int DEBOUNCE_TIME_IN_MILLIS = 300;

class TextAreaRating extends StatefulWidget {
  final Map<String, String> idAndTextHint;
  final Function(Map<String, String>) onRatingListener;

  TextAreaRating(this.idAndTextHint, this.onRatingListener);

  @override
  State<TextAreaRating> createState() => _TextAreaRatingState();
}

class _TextAreaRatingState extends State<TextAreaRating> {
  Timer _debounceTimer;

  @override
  Widget build(BuildContext context) {
    final id = widget.idAndTextHint.keys.first;
    final hint = widget.idAndTextHint.values.first ??
        AppLocalizations.of(context).hintTextArea;
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
          hintText: hint,
          fillColor: Colors.white.withOpacity(0.3),
        ),
        maxLines: 8,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: (text) => _onTextChanged(id, text),
      ),
    );
  }

  _onTextChanged(String id, String text) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
    final duration = const Duration(milliseconds: DEBOUNCE_TIME_IN_MILLIS);
    _debounceTimer = Timer(duration, () {
      widget.onRatingListener.call({id: text.trim()});
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
