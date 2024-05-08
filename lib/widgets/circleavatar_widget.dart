import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class circleavatar {
  circleAvatar({radius, child, bgcolor, required context, page, image}) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper().push(context: context, page: page);
      },
      child: CircleAvatar(
        backgroundImage: image,
        radius: radius,
        child: child,
        backgroundColor: bgcolor,
      ),
    );
  }

  categoryavatar({text, child, required context, ontap, page}) {
    return Column(
      children: [
        circleavatar().circleAvatar(
            page: page, context: context, child: child, radius: 30.0),
        SizedBox(
          height: 6,
        ),
        SizedBox(
          width: 60,
          child: Center(
            child: TextWidget().text(data: text, size: 12.0),
          ),
        )
      ],
    );
  }
}
