
[![flib build](https://github.com/ZuYun/loginj/actions/workflows/flibbuild.yml/badge.svg)](https://github.com/ZuYun/loginj/actions/workflows/flibbuild.yml) [![lib web](https://github.com/ZuYun/loginj/actions/workflows/flibweb.yml/badge.svg)](https://github.com/ZuYun/loginj/actions/workflows/flibweb.yml)    [![publish](https://github.com/ZuYun/loginj/actions/workflows/publish.yml/badge.svg)](https://github.com/ZuYun/loginj/actions/workflows/publish.yml)

# what is it

![flipover](https://raw.githubusercontent.com/ZuYun/loginj/main/preview/loginj.gif)

https://user-images.githubusercontent.com/9412501/145047584-5acfbd4a-a448-4d85-8878-2dd779d32f30.mp4

# how to use
[![pub](https://img.shields.io/badge/pub-v0.0.3-green)](https://pub.dev/packages/loginj)
- pub
```yaml
  dependencies:
    loginj: ^0.0.3
```
  
```dart
FlipOverj(
    firstFront: (context, aniValue) => firstFrontCard(context, aniValue),
    firstBack: (context, aniValue) => firstBackCard(context, aniValue),
    secondFront: (context, aniValue) => secondFrontCard(context, aniValue),
    secondBack: (context, aniValue) => secondBackCard(context, aniValue),
)
```

## customization
```dart
const FlipOverj({
    Key? key,
    required this.firstFront,
    required this.firstBack,
    required this.secondFront,
    required this.secondBack,
    this.offset = 50,
    this.secondScale = 0.85,
    this.firstScale = 0.8,
    this.duration = const Duration(milliseconds: 600),
})
```