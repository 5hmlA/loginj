import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:loginj/loginj.dart';
import 'package:loginj_example/widgets_factory.dart';

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
        appBar: AppBar(
          title: const Text('Plugin example app'),
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
                // child: Image.asset(
                //   "images/astro_mona.webp",
                //   fit: BoxFit.fill,
                //   scale: 4,
                // ),
              ),
            ),
            LoginPage(),
          ],
        ),
      ),
    );
  }
}
