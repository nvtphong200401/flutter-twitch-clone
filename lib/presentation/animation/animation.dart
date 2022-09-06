
import 'package:flutter/material.dart';

class FadedNavigation extends PageRouteBuilder {
  final Widget child;
  final bool reverse;
  FadedNavigation({ required this.child, this.reverse = false })
      : super(transitionDuration: Duration(milliseconds: 800), reverseTransitionDuration: Duration(milliseconds: 400), pageBuilder: (context, animation, secondaryAnimation) => child);

  static final Animatable<double> _fadeInTransition = CurveTween(
    curve: decelerateEasing,
  ).chain(CurveTween(curve: const Interval(0.3, 1.0)));

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {

    // Fades between routes. (If you don't want any animation,
    // just return child.)
    // return ScaleTransition(scale: animation, child: child,);
    final Animatable<Offset> slideInTransition = Tween<Offset>(
      begin: Offset(reverse ? 30.0 : -30.0, 0.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: standardEasing));
    return FadeTransition(
        opacity: _fadeInTransition.animate(animation),
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Transform.translate(
              offset: slideInTransition.evaluate(animation),
              child: child,
            );
          },
          child: child,
        ),
    );

    //   SlideTransition(
    //   position: Tween<Offset>(begin: Offset(-1,0), end: Offset.zero).animate(animation),
    //   child: child,
    // );
  }
}

class NavigateRightToLeftAnimation extends PageRouteBuilder {
  final Widget child;
  NavigateRightToLeftAnimation({ required this.child })
      : super(transitionDuration: Duration(milliseconds: 400), reverseTransitionDuration: Duration(milliseconds: 400), pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {

    // Fades between routes. (If you don't want any animation,
    // just return child.)
    // return ScaleTransition(scale: animation, child: child,);
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1,0), end: Offset.zero).animate(animation),
      child: child,
    );
  }
}