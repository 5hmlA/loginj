import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'login.dart';
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Loginj example'),
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Image.network(
                "https://github.githubassets.com/images/modules/site/home/globe.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox.expand(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.network(
                  "https://github.githubassets.com/images/modules/site/home/astro-mona.webp",
                  scale: 4.5,
                ),
              ),
            ),
            const LoginPage(),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // timeDilation = 20.0;
    return AnimatedSwitcher(
      transitionBuilder: (Widget child, Animation<double> animation) {
        //执行缩放动画
        return ScaleTransition(child: child, scale: animation);
      },
      duration: const Duration(milliseconds: 333),
      child: findShowChild(),
    );
  }

  findShowChild() {
    // return Loading();
    return const Padding(
      padding: EdgeInsets.all(24),
      child: LoginCard(),
    );
  }
}
