import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:survey/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) => Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                children: [
                  GetX<HomeController>(builder: (state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.currentDateText.value,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(height: 5),
                            Text(AppLocalizations.of(context).titleToday,
                                style: Theme.of(context).textTheme.headline4),
                          ],
                        ),
                        CircleAvatar(
                          radius: 22,
                          child: state.currentUserAvatar.value.isNotEmpty
                              ? NetworkImage(state.currentUserAvatar.value)
                              : SvgPicture.asset(
                                  'assets/images/avatar_placeholder.svg'),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
