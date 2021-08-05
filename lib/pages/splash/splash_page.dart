import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/navigator/navigator.dart';
import 'package:survey/pages/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  bool _isLogoAnimated = false;

  AnimationController _logoOpacityController;
  AnimationController _backgroundOpacityController;

  Animation<double> _logoAnimation;
  Animation<double> _backgroundAnimation;
  Animation<double> fadeOut;

  @override
  void initState() {
    _logoOpacityController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..forward();
    _logoAnimation = CurvedAnimation(
      parent: _logoOpacityController,
      curve: Curves.easeIn,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isLogoAnimated = !_isLogoAnimated;
            _backgroundOpacityController.forward();
          });
        }
      });

    _backgroundOpacityController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundOpacityController,
      curve: Curves.easeIn,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _loginStatusCheck();
        }
      });

    fadeOut = Tween<double>(begin: 1, end: -1).animate(
      _backgroundOpacityController.drive(CurveTween(curve: standardEasing)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.signInBackground,
                fit: BoxFit.fill,
              ),
            ),
          ),
          FadeTransition(
            opacity: fadeOut,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                color: Colors.white10,
              ),
            ),
          ),
          FadeTransition(
            opacity: _backgroundAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.8),
                      Colors.black,
                    ],
                    stops: [
                      0.0,
                      0.5,
                      1.0
                    ]),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.linear,
            child: Center(
              child: FadeTransition(
                opacity: _logoAnimation,
                child: SvgPicture.asset('assets/images/logo.svg'),
              ),
            ),
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            top: _isLogoAnimated ? -450 : 0.0,
          ),
        ],
      ),
    );
  }

  Future<void> _loginStatusCheck() async {
    final AppNavigator _appNavigator = Get.find();
    final splashController = SplashController();
    final isLoggedIn = await splashController.isLoggedInUser;
    if (isLoggedIn)
      _appNavigator.popAndNavigateToHome();
    else
      _appNavigator.popAndNavigateToLogin();
  }
}
