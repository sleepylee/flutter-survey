import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String RATING_TYPE_TEXT_FIELD = "textfield";
const int DEBOUNCE_TIME_IN_MILLIS = 300;

class TextFieldRating extends StatefulWidget {
  final Map<String, String> idAndHints;
  final Function(Map<String, String>) onRatingListener;

  const TextFieldRating(
      {Key key, this.idAndHints, @required this.onRatingListener})
      : super(key: key);

  @override
  State<TextFieldRating> createState() => _TextFieldRatingState();
}

class _TextFieldRatingState extends State<TextFieldRating> {
  Timer _debounceTimer;
  Map<String, String> idAndAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: _makeTextFields(context, widget.idAndHints),
          ),
        ),
      ),
    );
  }

  List<Widget> _makeTextFields(
      BuildContext context, Map<String, String> idAndHint) {
    final textFields = <Widget>[];
    final ids = idAndHint.keys.toList();
    final hints = idAndHint.values.toList();

    ids.asMap().forEach((index, id) {
      textFields.add(
        Padding(
          padding: index == hints.length - 1
              ? EdgeInsets.only(top: 10)
              : EdgeInsets.symmetric(vertical: 10),
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
              hintText: hints[index] ?? "",
              fillColor: Colors.white.withOpacity(0.3),
            ),
            style: Theme.of(context).textTheme.bodyText1,
            textInputAction: index == hints.length - 1
                ? TextInputAction.done
                : TextInputAction.next,
            onChanged: (text) => _onTextChanged(id, text),
          ),
        ),
      );
    });

    return textFields;
  }

  _onTextChanged(String id, String text) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
    final duration = const Duration(milliseconds: DEBOUNCE_TIME_IN_MILLIS);
    _debounceTimer = Timer(duration, () {
      idAndAnswer[id] = text.trim();
      widget.onRatingListener.call(idAndAnswer);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
