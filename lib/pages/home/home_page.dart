import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/pages/home/home_controller.dart';

import '../../flavors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) => Center(
          child: Text(
            'Home Page ${F.title}',
          ),
        ),
      ),
    );
  }
}
