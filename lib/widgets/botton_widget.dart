import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
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
        size: size.width * .055,
        color: textcolor,
      ),
    );
  }

  textbutton(
      {onpressed, text, pushpage, required context, replacementpage, weight}) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        pro.clearControllers();
        NavigatorHelper().push(context: context, page: pushpage);
      },
      child: TextWidget().text(
          data: text,
          color: Colors.black,
          size: size.width * .025,
          weight: weight),
    );
  }
}
