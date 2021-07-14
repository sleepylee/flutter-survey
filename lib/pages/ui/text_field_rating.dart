import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String RATING_TYPE_TEXT_FIELD = "textfield";

class TextFieldRating extends StatelessWidget {
  final List<String> hints;

  const TextFieldRating({Key key, this.hints}) : super(key: key);

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
            children: _makeTextFields(context, hints),
          ),
        ),
      ),
    );
  }

  List<Widget> _makeTextFields(BuildContext context, List<String> hints) {
    final textFields = <Widget>[];

    hints.asMap().forEach((index, element) {
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
              hintText: element ?? "",
              fillColor: Colors.white.withOpacity(0.3),
            ),
            style: Theme.of(context).textTheme.bodyText1,
            textInputAction: index == hints.length - 1
                ? TextInputAction.done
                : TextInputAction.next,
          ),
        ),
      );
    });

    return textFields;
  }
}
