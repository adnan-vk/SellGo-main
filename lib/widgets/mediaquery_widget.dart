import 'package:flutter/material.dart';

class MediaQueryWidget {
  double width(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }

  double height(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * size;
  }
}
