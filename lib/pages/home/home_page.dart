import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/pages/home/home_controller.dart';
import 'package:survey/pages/home/survey_carousel/survey_carousel_card.dart';
import 'package:survey/pages/home/survey_carousel/survey_ui_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) => Stack(children: [
          SurveyCarouselCard(
            // TODO: implement the carousel list next and remove these
            surveyUiModel: SurveyUiModel(
              id: "111",
              title: "Mock Title: Scarlett Bangkok ",
              description:
                  "Mock Description: We'd love ot hear from you! Or a very long paragraph here to test the UI display",
              imageUrl:
                  "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l",
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                children: [
                  GetX<HomeController>(
                    builder: (state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.currentDateText,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 5),
                              Text(AppLocalizations.of(context).titleToday,
                                  style: Theme.of(context).textTheme.headline4),
                            ],
                          ),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.black12,
                            foregroundImage:
                                state.currentUserAvatarUrl.isNotEmpty
                                    ? NetworkImage(state.currentUserAvatarUrl)
                                    : Assets.images.avatarPlaceholder,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
