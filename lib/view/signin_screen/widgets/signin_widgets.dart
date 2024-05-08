import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/view/phone_page/phone.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/card_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/textfield_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signinWidgets {
  textfields(context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    return Column(
      children: [
        textFormField().textformfield(
            keytype: TextInputType.emailAddress,
            icon: Icon(EneftyIcons.user_outline),
            controller: pro.emailController,
            hinttext: "Email Address",
            type: "Email",
            color: Colors.grey.shade200),
        SizedBox(
          height: size.height * .02,
        ),
        textFormField().textformfield(
          maxline: 1,
          obsc: true,
          icon: Icon(EneftyIcons.lock_outline),
          controller: pro.passwordController,
          hinttext: "Password",
          type: "Password",
          color: Colors.grey.shade200,
        ),
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ButtonWidget().textbutton(
              context: context,
              text: "Forgot Password?",
              weight: FontWeight.bold),
        )
      ],
    );
  }

  cardwidget(context) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        CardWidget().card(
          ontap: () async {
            try {
              await pro.googleSignIn(context);
              // pro.addUser();
            } catch (e) {
              return;
            }
          },
          url:
              'https://cdn.iconscout.com/icon/free/png-256/free-google-1772223-1507807.png',
          text: "Continue With Google",
          context: context,
        ),
        SizedBox(
          height: size.height * .022,
        ),
        CardWidget().card(
          ontap: () => NavigatorHelper().push(
            context: context,
            page: OtpPage(),
          ),
          url: 'https://cdn-icons-png.freepik.com/256/100/100313.png',
          text: "Continue With OTP",
          context: context,
        )
      ],
    );
  }
}
