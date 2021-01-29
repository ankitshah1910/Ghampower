import 'package:flutter/material.dart';



class AnimatedProgressBar extends AnimatedWidget {
  AnimatedProgressBar({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: 8.0,
      width: animation.value,
      decoration: BoxDecoration(color: Colors.blueGrey),
    );
  }
}