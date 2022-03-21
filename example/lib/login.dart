import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginj/loginj.dart';

import 'login_widgets.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FlipOverj(
      firstFront: firstFront,
      firstBack: firstBack,
      secondFront: secFront,
      secondBack: secBack,
    );
    return FlipOverj(
      firstFront: (context, aniValue) => firstFrontCard(context, aniValue),
      firstBack: (context, aniValue) => firstBackCard(context, aniValue),
      secondFront: (context, aniValue) => secondFrontCard(context, aniValue),
      secondBack: (context, aniValue) => secondBackCard(context, aniValue),
    );
  }
}

void toggle(BuildContext context) {
  FlipOverj.of(context)?.toggle();
}

Widget firstFront(BuildContext context, double aniValue) {
  return Card(
    color: Colors.red,
    child: InkWell(
      onTap: () {
        toggle(context);
      },
      child: SizedBox(
        width: 300,
        height: 480 - 180 * aniValue,
        child: const FlutterLogo(),
      ),
    ),
  );
}

Widget firstBack(BuildContext context, double aniValue) {
  return Card(
    color: Colors.red,
    child: InkWell(
      onTap: () {
        toggle(context);
      },
      child: SizedBox(
        width: 300,
        height: 480 - 180 * aniValue,
        child: const FlutterLogo(),
      ),
    ),
  );
}

Widget secFront(BuildContext context, double aniValue) {
  return Card(
    color: Colors.blueAccent,
    child: InkWell(
      onTap: () {
        toggle(context);
      },
      child: const SizedBox(
        width: 300,
        height: 300,
        child: const FlutterLogo(),
      ),
    ),
  );
}

Widget secBack(BuildContext context, double aniValue) {
  return Card(
    color: Colors.blueAccent,
    child: InkWell(
      onTap: () {
        toggle(context);
      },
      child: const SizedBox(
        width: 300,
        height: 300,
        child: const FlutterLogo(),
      ),
    ),
  );
}
