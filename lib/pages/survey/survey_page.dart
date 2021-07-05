import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:survey/navigator/const.dart';

class SurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final surveyId = Get.arguments[DATA_SURVEY_ID];

    // TODO: work on the Integrated data later
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l"),
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
                            "Test $surveyId, Test Title, Test Title, Test Title, Test Title, Test Title, Test Title, ",
                            style: Theme.of(context).textTheme.headline4,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Test Description, Test Description Test Description, Test Description Test Description, Test Description Test Description, Test Description Test Description, Test Description ",
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
                // TODO: complete survey
              },
            ),
          ).marginOnly(bottom: 50, right: 24),
        ],
      ),
    );
  }
}
