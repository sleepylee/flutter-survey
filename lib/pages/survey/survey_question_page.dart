import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/pages/survey/survey_answer.dart';
import 'package:survey/pages/survey/survey_controller.dart';

class SurveyQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SurveyController>(builder: (controller) {
        // TODO: use Question instead when doing the Integration
        final survey = controller.optionalSurvey.value;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // TODO: update this with the Survey Question's coverImageUrl
                  image: CachedNetworkImageProvider(survey.hdCoverImageUrl,
                      cacheKey: survey.id),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.overlay),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      color: Colors.white.withOpacity(0.2),
                      height: 28,
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: update this behavior: show confirmation dialog
                        Get.back();
                      },
                      shape: CircleBorder(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TODO: 1/5",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Colors.white70, fontSize: 15),
                            ),
                            Text(
                              "TODO: How satisfied you are?",
                              style: Theme.of(context).textTheme.headline4,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ).marginOnly(top: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // TODO: remove these:
            SurveyAnswer(
              type: "choice", // TODO: Come from API
              optionsText: ["Yes", "No", "Ok"],
            ).marginOnly(top: 85),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: const Icon(
                  Icons.chevron_right,
                  size: 50,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.snackbar("TODO", "Move to the next question",
                      backgroundColor: Colors.white);
                },
              ),
            ).marginOnly(bottom: 50, right: 24),
          ],
        );
      }),
    );
  }
}
