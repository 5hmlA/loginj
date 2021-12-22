import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginj/loginj.dart';

import 'login_widgets.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
