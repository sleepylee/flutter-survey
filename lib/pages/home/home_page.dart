import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/pages/home/home_controller.dart';
import 'package:survey/pages/home/survey_carousel/survey_carousel_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RefreshController pullToRefreshController =
        RefreshController(initialRefresh: false);

    PageController pagingController = PageController();
    return Scaffold(
      body: GetBuilder(
          init: HomeController(),
          builder: (HomeController controller) => SmartRefresher(
                enablePullDown: true,
                controller: pullToRefreshController,
                header: MaterialClassicHeader(
                  // TODO: if we support Dark mode, use Theme for this too
                  backgroundColor: Colors.black12,
                  color: Theme.of(context).accentColor,
                ),
                onRefresh: () async {
                  controller.refreshData(() {
                    pullToRefreshController.refreshCompleted();
                    pagingController.jumpToPage(0);
                  });
                },
                child: Stack(children: [
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
                        controller: pagingController,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.currentDateText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                          AppLocalizations.of(context)
                                              .titleToday,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.black12,
                                    foregroundImage:
                                        state.currentUserAvatarUrl != null &&
                                                state.currentUserAvatarUrl
                                                    .isNotEmpty
                                            ? NetworkImage(
                                                state.currentUserAvatarUrl)
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
              )),
    );
  }
}
