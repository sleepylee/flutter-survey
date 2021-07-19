import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/pages/survey/survey_controller.dart';

class MultipleChoiceRating extends StatefulWidget {
  final Map<String, String> idAndChoice;

  const MultipleChoiceRating({Key key, this.idAndChoice}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultipleChoiceRatingState();
}

class _MultipleChoiceRatingState extends State<MultipleChoiceRating> {
  final _selectedIndexes = <int>[];
  final _surveyController = Get.find<SurveyController>();

  bool _isSelected(int index) {
    return _selectedIndexes.contains(index);
  }

  void _onItemSelected(int index) {
    setState(() {
      _isSelected(index)
          ? _selectedIndexes.remove(index)
          : _selectedIndexes.add(index);
      final answers = Map.fromIterable(_selectedIndexes,
          key: (e) => widget.idAndChoice.keys.toList()[e], value: (_) => "");
      _surveyController.onAnswerSelected(answers);
    });
  }

  bool _shouldDrawDivider(int index) {
    return index == widget.idAndChoice.values.length - 1 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.idAndChoice.values.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onItemSelected(index);
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.idAndChoice.values.toList()[index],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 20,
                              fontWeight: _isSelected(index)
                                  ? FontWeight.w800
                                  : FontWeight.w400,
                              color: _isSelected(index)
                                  ? Colors.white
                                  : Colors.white54),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Icon(Icons.check_circle,
                            size: 25,
                            color: _isSelected(index)
                                ? Colors.white
                                : Colors.white12),
                        flex: 1,
                      )
                    ],
                  ),
                  if (_shouldDrawDivider(index))
                    const Divider(
                      color: Colors.white,
                      height: 30,
                      thickness: 1,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
