import 'package:flutter/material.dart';

// to be reused as a navigator for switching pages

void navigateNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => nextPage),
  );
}
