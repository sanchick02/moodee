import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class AppShadow {
  static BoxShadow innerShadow1 = BoxShadow(
    offset: const Offset(-4, -4),
    blurRadius: 8,
    color: Colors.black.withOpacity(0.8),
    inset: true,
  );

  static BoxShadow innerShadow2 = BoxShadow(
    offset: const Offset(4, 4),
    blurRadius: 40,
    color: Colors.black.withOpacity(0.3),
    inset: true,
  );

  static BoxShadow innerShadow3 = BoxShadow(
    offset: const Offset(-4, -4),
    blurRadius: 8,
    color: Colors.black.withOpacity(0.3),
    inset: true,
  );

  static BoxShadow innerShadow4 = BoxShadow(
    offset: const Offset(4, 4),
    blurRadius: 20,
    color: Colors.black.withOpacity(0.3),
    inset: true,
  );
}
