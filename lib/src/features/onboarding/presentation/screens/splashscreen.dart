import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/routes/app_router.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({required this.loggedIn, super.key});
  final bool loggedIn;

  static const routeName = '/splashscreen';

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        widget.loggedIn
            ? context.goNamed(AppRoute.notes.name)
            : context.goNamed(AppRoute.signIn.name);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return const Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      body: Center(
        child: Hero(
          tag: 'wordie',
          child: Text(
            'WORDIE',
            style: TextStyle(
                letterSpacing: 10.0,
                color: Colors.black,
                fontSize: 55,
                // height: 1,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    ).darkStatusBar();
  }
}
