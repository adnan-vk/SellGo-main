import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonWidget {
  elevatedbutton(
      {text, color, required context, page, textcolor, icon, iconcolor}) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () => NavigatorHelper()
          .pushReplacement(context: context, replacementPage: page),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.only(top: 10, bottom: 10),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      child: TextWidget().text(
        data: text,
        size: 20.0,
        color: textcolor,
      ),
    );
  }

  textbutton(
      {onpressed, text, pushpage, required context, replacementpage, weight}) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        pro.clearControllers();
        NavigatorHelper().push(context: context, page: pushpage);
      },
      child: TextWidget()
          .text(data: text, color: Colors.black, size: 8.0, weight: weight),
    );
  }

  leadingIcon(context) {
    return IconButton(
      onPressed: () {
        NavigatorHelper().pop(context: context);
      },
      icon: Icon(
        EneftyIcons.arrow_left_3_outline,
        color: Colors.black,
      ),
    );
  }
}
