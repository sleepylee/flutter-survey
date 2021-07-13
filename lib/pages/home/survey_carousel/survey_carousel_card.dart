import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/home/survey_carousel/survey_ui_model.dart';
import 'package:survey/pages/ui/indicators_widget.dart';

// ignore: must_be_immutable
class SurveyCarouselCard extends StatelessWidget {
  SurveyCarouselCard({required this.surveyUiModel});

  final SurveyUiModel surveyUiModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: CachedNetworkImageProvider(surveyUiModel.imageUrl,
            cacheKey: surveyUiModel.id),
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
                  Indicators(currentPage: surveyUiModel.index),
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
                            _navigateToSurveyDetail(surveyUiModel.id);
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

  void _navigateToSurveyDetail(String id) {
    final navigator = Get.find<AppNavigator>();
    navigator.navigateToSurvey(id);
  }
}
