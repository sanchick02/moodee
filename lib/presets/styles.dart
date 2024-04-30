import 'package:flutter/material.dart';

class AppStyles {
  // BORDER RADIUS
  static const BorderRadius borderRadiusBottom = BorderRadius.only(
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  static const BorderRadius borderRadiusTop = BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  );

  static const BorderRadius borderRadiusAll = BorderRadius.all(
    Radius.circular(20),
  );

  // MARGIN AND PADDING
  static const EdgeInsets edgeInsetsAll = EdgeInsets.all(20);
  static const EdgeInsets edgeInsetsLeft = EdgeInsets.only(left: 20);
  static const EdgeInsets edgeInsetsRight = EdgeInsets.only(right: 20);
  static const EdgeInsets edgeInsetsTop = EdgeInsets.only(top: 20);
  static const EdgeInsets edgeInsetsBottom = EdgeInsets.only(bottom: 20);
  static const EdgeInsets edgeInsetsLRT =
      EdgeInsets.only(left: 20, right: 20, top: 20);
  static const EdgeInsets edgeInsetsLR = EdgeInsets.only(left: 20, right: 20);
  static const EdgeInsets edgeInsetsTB = EdgeInsets.only(top: 20, bottom: 20);
}
