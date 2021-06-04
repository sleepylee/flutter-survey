import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TODO: Bind real data (date & user profile) later in [Integrate].
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            new DateFormat('EEEE, MMMM dd')
                                .format(DateTime.now())
                                .toUpperCase(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 5),
                          Text(AppLocalizations.of(context).titleToday,
                              style: Theme.of(context).textTheme.headline4),
                        ],
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage:
                            NetworkImage('https://picsum.photos/250?image=9'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
