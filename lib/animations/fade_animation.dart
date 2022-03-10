import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({
    Key? key,
    this.begin = 0,
    this.end = 1,
    this.intervalStart = 0,
    this.intervalEnd = 1,
    this.duration = const Duration(
      milliseconds: 3000,
    ),
    this.curve = Curves.fastOutSlowIn,
    required this.child,
  }) : super(key: key);

  final double begin;
  final double end;
  final double intervalStart;
  final double intervalEnd;
  final Duration duration;
  final Curve curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin, end: end),
      duration: duration,
      curve: Interval(intervalStart, intervalEnd, curve: curve),
      builder: (BuildContext context, double? value, Widget? child) {
        return Opacity(
          opacity: value!,
          child: child,
        );
      },
      child: child,
    );
  }
}
