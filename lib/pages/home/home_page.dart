import 'package:flutter/material.dart';

import '../../flavors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Page ${F.title}',
        ),
      ),
    );
  }
}
