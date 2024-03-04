import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {

  void push(Widget screen) {
    Navigator.push(this, MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  void pop() {
    Navigator.pop(this);
  }
}

extension WidgetExtensions on Widget {
  Widget padX(double? size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size!),
        child: this,
      );

  Widget padY(double? size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size!),
        child: this,
      );

  Widget padAll(double? size) => Padding(
        padding: EdgeInsets.all(size!),
        child: this,
      );
}