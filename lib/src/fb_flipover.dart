import 'dart:math';

import 'package:flutter/widgets.dart';

import '../loginj.dart';

/// aniValue 0-1 后面到前面
typedef AniBuilder = Widget Function(BuildContext context, double aniValue);

@immutable
class FlipOverj extends StatefulWidget {
  final AniBuilder firstFront;
  final AniBuilder firstBack;
  final AniBuilder secondFront;
  final AniBuilder secondBack;
  final double offset;
  final double secondScale;
  final double firstScale;
  final Duration duration;

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
  }) : super(key: key);

  static FlipOverjState? of(BuildContext context) {
    FlipOverjState? state = context.findAncestorStateOfType<FlipOverjState>();
    if (state == null && context is StatefulElement) {
      if (context.state is FlipOverjState) {
        return context.state as FlipOverjState;
      }
    }
    return state;
  }

  @override
  FlipOverjState createState() => FlipOverjState();
}

class FlipOverjState extends State<FlipOverj> with SingleTickerProviderStateMixin {
  late AnimationController _animationControl;
  final _Z = 60;
  bool _firstShow = true;
  AnimationStatusListener? _statusListener;
  final double _showFrom = 100;

  /// _firstFront, _firstBack,_secFront_secBack;
  final Map<int, Widget> _cache = {};

  toggle() {
    if (_animationControl.value == 0) {
      _animationControl.forward();
    } else {
      _animationControl.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationControl = AnimationController(vsync: this, duration: widget.duration);
    _statusListener = (status) {
      if (status == AnimationStatus.completed) {
        onAnimateFirstComplete();
      }
    };
    _animationControl.addStatusListener(_statusListener!);
    _animationControl.forward();
  }

  void onAnimateFirstComplete() {
    if (_firstShow) {
      _animationControl.reset();
      // _animationControl.duration = widget.duration;
    }
    _animationControl.removeStatusListener(_statusListener!);
    setState(() {
      _firstShow = false;
    });
  }

  @override
  void dispose() {
    _cache.clear();
    _animationControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_firstShow) {
      return _firstShowAnimation();
    }
    return RepaintBoundary(
      child: AnimatedBuilder(
          animation: _animationControl,
          builder: (BuildContext context, Widget? child) {
            if (easeOutAniValue(_animationControl.value) <= .5) {
              return back2half(context);
            } else {
              return half2front(context);
            }
          }),
    );
  }

  Widget _firstShowAnimation() {
    Widget firstFront = findWidget(widget.firstFront, context, 0, 1);
    Widget secBack = findWidget(widget.secondBack, context, 0, 4);
    return RepaintBoundary(
      child: AnimatedBuilder(
          animation: _animationControl,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: widget.offset),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(1, 3, -widget.offset * (.5) + offsetSlow())
                      ..setEntry(3, 3, 1 / widget.secondScale)
                      ..translate(.0, .0, _Z.toDouble()),
                    alignment: Alignment.center,
                    child: secBack,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widget.offset),
                  child: Transform.translate(
                    offset: Offset(0, widget.offset + offsetNormal()),
                    child: firstFront,
                  ),
                ),
              ],
            );
          }),
    );
  }

  double offsetNormal() {
    return _showFrom * (1 - Curves.ease.transformInternal(_animationControl.value));
  }

  double offsetSlow() {
    return 1.1 *
        _showFrom *
        (2.22 * Curves.ease.transformInternal(1 - _animationControl.value).clamp(0, 1));
  }

  /// 后面的第二个 往前转 变为第一个  0 - 0.5
  Stack back2half(BuildContext context) {
    double aniFoldValue = easeOutAniValue(_animationControl.value);
    var secondBackScale = (widget.secondScale + 2 * (1 - widget.secondScale) * aniFoldValue);
    var firstFrontScale = (widget.firstScale + (1 - widget.firstScale) * (1 - aniFoldValue));
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001 * Curves.easeOutCirc.transform(-2 * aniFoldValue + 1))
              ..setEntry(1, 3, -widget.offset * (aniFoldValue + .5))
              ..rotateX(pi * 1 * aniFoldValue)
              ..setEntry(3, 3, 1 / secondBackScale)
              ..translate(.0, 0, _Z * (1 - easeInAniValue(aniFoldValue))),
            alignment: Alignment.center,
            child: findWidget(widget.secondBack, context, aniFoldValue, 4),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 3, 1 / firstFrontScale)
              ..setEntry(1, 3, widget.offset),
            child: findWidget(widget.firstFront, context, aniFoldValue, 1),
          ),
        ),
      ],
    );
  }

  /// 0.5 - 1
  Stack half2front(BuildContext context) {
    double aniFoldValue = easeOutAniValue(_animationControl.value);
    var firstBackScale = (widget.firstScale + (1 - widget.firstScale) * (1 - aniFoldValue));
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 3, 1 / firstBackScale)
              ..setEntry(1, 3, widget.offset),
            child: findWidget(widget.firstBack, context, aniFoldValue, 2),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001 * Curves.easeOutCirc.transform(2 * aniFoldValue - 1))
              ..setEntry(1, 3, 2 * widget.offset * (aniFoldValue - 1))
              ..rotateX(pi * 1 * aniFoldValue)
              ..translate(.0, 0.0, _Z * (1 - easeInAniValue(aniFoldValue))),
            alignment: Alignment.center,
            child: findWidget(widget.secondFront, context, aniFoldValue, 3),
          ),
        ),
      ],
    );
  }

  double easeInAniValue(double value) {
    return Curves.easeInExpo.transformInternal(value);
  }

  double easeOutAniValue(double value) {
    return Curves.easeOutQuad.transformInternal(value);
  }

  Widget findWidget(AniBuilder builder, BuildContext context, double aniValue, int index) {
    Widget? temp = _cache[index];
    if (temp != null) {
      return temp;
    }
    Widget buildWidget = builder(context, aniValue);
    if (buildWidget is Stone) {
      _cache[index] = buildWidget;
    }
    return buildWidget;
  }
}
