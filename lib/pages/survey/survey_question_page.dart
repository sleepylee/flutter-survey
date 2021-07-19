import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/pages/survey/survey_answer_selection.dart';
import 'package:survey/pages/survey/survey_controller.dart';

class SurveyQuestionPage extends StatelessWidget {
  final PageController _answersController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder(
          init: SurveyController(),
          builder: (_) {
            return GetX<SurveyController>(builder: (controller) {
              if (controller.nextQuestionImage != null) {
                precacheImage(
                    CachedNetworkImageProvider(controller.nextQuestionImage),
                    context);
              }
              return Stack(
                children: [
                  _buildBackground(controller.currentQuestion),
                  _buildTitle(
                      context: context,
                      indexTitle: controller.indexTitleText,
                      questionTitle: controller.currentQuestion.text,
                      isEmptyAnswer:
                          controller.currentQuestion.doesNotRequireAnswer),
                  _buildAnswerBody(controller.optionalSurvey.value.questions),
                  _buildSubmitButton(),
                ],
              );
            });
          }),
    );
  }

  Widget _buildBackground(SurveyQuestion question) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(question.hdCoverImageUrl,
                  cacheKey: question.id),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.black54,
        )
      ],
    );
  }

  Widget _buildExitQuestionButton() {
    return Align(
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
    );
  }

  Widget _buildTitle(
      {BuildContext context,
      String indexTitle,
      String questionTitle,
      bool isEmptyAnswer = false}) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExitQuestionButton(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      indexTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      questionTitle,
                      style: Theme.of(context).textTheme.headline4,
                      maxLines: isEmptyAnswer ? 10 : 3,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(top: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerBody(List<SurveyQuestion> questions) {
    return SafeArea(
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Center(
          child: SurveyAnswerSelection(
            type: questions[index].displayType,
            optionIdAndText: Map.fromIterable(questions[index].answers,
                key: (e) => e.id, value: (e) => e.text),
            counter: questions[index].answers.length ?? 0,
          ),
        ),
        itemCount: questions.length,
        controller: _answersController,
        onPageChanged: (index) {},
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        child: const Icon(
          Icons.chevron_right,
          size: 50,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          _answersController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.ease);
          final surveyController = Get.find<SurveyController>();
          surveyController.onNextQuestion();
        },
      ),
    ).marginOnly(bottom: 50, right: 24);
  }
}
