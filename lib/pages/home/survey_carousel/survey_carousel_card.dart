import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/pages/home/survey_carousel/survey_ui_model.dart';

// ignore: must_be_immutable
class SurveyCarouselCard extends StatelessWidget {
  SurveyCarouselCard({this.surveyUiModel});

  final SurveyUiModel surveyUiModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(surveyUiModel.imageUrl),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.overlay),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Wrap(
                children: [
                  _updateIndicators(0),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              surveyUiModel.title,
                              style: Theme.of(context).textTheme.headline5,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              surveyUiModel.description,
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: FloatingActionButton(
                          child: const Icon(
                            Icons.chevron_right,
                            size: 50,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            // TODO: Add click action
                          },
                        ),
                        flex: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _updateIndicators(int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getIndicators(currentPage),
    );
  }

  List<Widget> _getIndicators(int currentPage) {
    final result = <Widget>[];
    for (int i = 0; i < 3; i++) {
      result.add(Container(
        width: 7.0,
        height: 7.0,
        margin: EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (currentPage % 3 == i) ? Colors.white : Colors.white24,
        ),
      ));
    }
    return result;
  }
}
