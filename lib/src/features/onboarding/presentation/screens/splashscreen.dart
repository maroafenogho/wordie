import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/features/auth/presentation/screens/wrapper.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  static const routeName = '/splashscreen';

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      context.goNamed(Wrapper.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: const FittedBox(
            child: Text(
          'WORDIE',
          style: TextStyle(
              letterSpacing: 10.0,
              color: Colors.black,
              fontSize: 55,
              // height: 1,
              fontWeight: FontWeight.w900),
        )),
      ),
    );
  }
}
