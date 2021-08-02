import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/pages/home/home_controller.dart';
import 'package:survey/pages/home/survey_carousel/survey_carousel_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) => Stack(children: [
          GetX<HomeController>(
            builder: (state) {
              return PageView.builder(
                itemBuilder: (context, index) {
                  return Opacity(
                    opacity: 1,
                    child: SurveyCarouselCard(
                        surveyUiModel: state.surveyUiModels[index]),
                  );
                },
                itemCount: state.surveyUiModels.length,
                controller: PageController(),
                onPageChanged: (index) {
                  final controller = Get.find<HomeController>();
                  controller.onIndexChanged(index);
                },
              );
            },
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
                                state.currentUserAvatarUrl != null &&
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
