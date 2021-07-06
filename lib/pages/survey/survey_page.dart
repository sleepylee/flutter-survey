import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/pages/survey/survey_controller.dart';

class SurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SurveyController(),
        builder: (controller) => GetX<SurveyController>(
          builder: (state) {
            return state.optionalSurvey.isPresent
                ? SurveyDetail(state: state)
                // TODO: change this to the loading shimmer layout later
                : ColoredBox(color: Colors.white12);
          },
        ),
      ),
    );
  }
}

class SurveyDetail extends StatelessWidget {
  SurveyDetail({this.state});

  final SurveyController state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(state.optionalSurvey.value.hdCoverImageUrl),
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
              IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.optionalSurvey.value.title,
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          state.optionalSurvey.value.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white70, fontSize: 17),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Text(AppLocalizations.of(context).buttonStartSurvey),
            ),
            onPressed: () {
              Get.snackbar(
                  "TODO", "Go to Survey: ${state.optionalSurvey.value.id}",
                  backgroundColor: Colors.white70);
            },
          ),
        ).marginOnly(bottom: 50, right: 24),
      ],
    );
  }
}
