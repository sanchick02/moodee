import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color color;

  CustomCircularProgressIndicator({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CircularProgressIndicator(
        strokeWidth: 10,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
