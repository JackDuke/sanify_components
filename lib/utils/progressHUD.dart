// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  ProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.4,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          // ignore: prefer_const_constructors
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }
}
