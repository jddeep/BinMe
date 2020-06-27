import 'package:flutter/material.dart';

class CustomRouteTransition {
  Route createPageRoute({navigateTo}) {
    return PageRouteBuilder(
      pageBuilder: (context, routeAnimation, seconderyAnimation) => navigateTo,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1, 0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
