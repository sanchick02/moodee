import 'package:flutter/material.dart';

class AppStyles {
  // BORDER RADIUS
  static const BorderRadius borderRadiusBottom = BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
  );

  static const BorderRadius borderRadiusTop = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  );

  static const BorderRadius borderRadiusAll = BorderRadius.all(
    Radius.circular(30),
  );

  // MARGIN AND PADDING
  static const EdgeInsets edgeInsetsAll = EdgeInsets.all(30);
  static const EdgeInsets edgeInsetsLeft = EdgeInsets.only(left: 30);
  static const EdgeInsets edgeInsetsRight = EdgeInsets.only(right: 30);
  static const EdgeInsets edgeInsetsTop = EdgeInsets.only(top: 30);
  static const EdgeInsets edgeInsetsBottom = EdgeInsets.only(bottom: 30);
  static const EdgeInsets edgeInsetsLRT =
      EdgeInsets.only(left: 30, right: 30, top: 30);
  static const EdgeInsets edgeInsetsLR = EdgeInsets.only(left: 30, right: 30);
  static const EdgeInsets edgeInsetsTB = EdgeInsets.only(top: 30, bottom: 30);
}
