import 'package:flutter/material.dart';

class NavigatorHelper {
   push({required BuildContext context, Widget? page}) {
    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }

  void pushReplacement(
      {required BuildContext context, Widget? replacementPage}) {
    if (replacementPage != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => replacementPage,
        ),
      );
    }
  }

   pop({required BuildContext context}) {
    Navigator.pop(context);
  }
}
