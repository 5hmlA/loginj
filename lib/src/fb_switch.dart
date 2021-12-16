import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../loginj.dart';



/// aniValue 0-1 后面到前面
typedef AniBuilder = Widget Function(BuildContext context, double aniValue);

@immutable
class Switchej extends StatefulWidget {
  final AniBuilder firstFront;
  final AniBuilder firstBack;
  final AniBuilder secondFront;
  final AniBuilder secondBack;
  final double offset;
  final Duration duration;

  const Switchej({
    Key? key,
    required this.firstFront,
    required this.firstBack,
    required this.secondFront,
    required this.secondBack,
    this.offset = 150,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  static SwitchejState? of(BuildContext context) {
    SwitchejState? state = context.findAncestorStateOfType<SwitchejState>();
    if (state == null && context is StatefulElement) {
      if (context.state is SwitchejState) {
        return context.state as SwitchejState;
      }
      print("of > [context] === $context ");
    }
    return state;
  }

  @override
  SwitchejState createState() => SwitchejState();
}

class SwitchejState extends State<Switchej> with SingleTickerProviderStateMixin {
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
    Widget firstFrount = findWidget(widget.firstFront, context, 0, 1);
    Widget secBack = findWidget(widget.secondBack, context, 0, 4);
    return RepaintBoundary(
      child: AnimatedBuilder(
          animation: _animationControl,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: widget.offset),
                  child: Transform.translate(
                    offset: Offset(0, -widget.offset * (.5) + offsetSlow()),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(.0, .0, _Z.toDouble()),
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scale: 0.85,
                        child: secBack,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widget.offset),
                  child: Transform.translate(
                    offset: Offset(0, widget.offset + offsetNormal()),
                    child: firstFrount,
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

  /// 后面的第二个 往前转 变为第一个
  Stack back2half(BuildContext context) {
    double aniFoldValue = easeOutAniValue(_animationControl.value);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform.translate(
            offset: Offset(0, -widget.offset * (aniFoldValue + .5)),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(pi * 1 * aniFoldValue)
                ..translate(.0, 0, _Z * (1 - easeInAniValue(aniFoldValue))),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 0.85 + 0.3 * aniFoldValue,
                child: findWidget(widget.secondBack, context, aniFoldValue, 4),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform.translate(
            offset: Offset(0, widget.offset),
            child: Transform.scale(
              scale: 0.8 + 0.2 * (1 - aniFoldValue),
              alignment: Alignment.bottomCenter,
              child: findWidget(widget.firstFront, context, aniFoldValue, 1),
            ),
          ),
        ),
      ],
    );
  }

  Stack half2front(BuildContext context) {
    double aniFoldValue = easeOutAniValue(_animationControl.value);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform.translate(
            offset: Offset(0, widget.offset),
            child: Transform.scale(
              scale: 0.8 + 0.2 * (1 - aniFoldValue),
              alignment: Alignment.bottomCenter,
              child: findWidget(widget.firstBack, context, aniFoldValue, 2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.offset),
          child: Transform.translate(
            offset: Offset(0, 2 * widget.offset * (aniFoldValue - 1)),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(pi * 1 * aniFoldValue)
                ..translate(.0, 0.0, _Z * (1 - easeInAniValue(aniFoldValue))),
              alignment: Alignment.center,
              child: Transform(
                transform: Matrix4.identity()..rotateX(pi),
                alignment: Alignment.center,
                child: findWidget(widget.secondFront, context, aniFoldValue, 3),
              ),
            ),
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