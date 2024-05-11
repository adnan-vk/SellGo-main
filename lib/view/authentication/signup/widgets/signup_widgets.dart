import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/widgets/textfield_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signupWidget {
  textfields({required context}) {
    final pro = Provider.of<AuthenticationProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        textFormField().textformfield(
            keytype: TextInputType.name,
            icon: Icon(Icons.abc),
            controller: pro.firstnamecontroller,
            hinttext: "First Name",
            color: Colors.grey.shade200),
        SizedBox(
          height: size.height * .02,
        ),
        textFormField().textformfield(
            keytype: TextInputType.name,
            icon: Icon(Icons.abc),
            controller: pro.lastnamecontroller,
            hinttext: "Last Name",
            color: Colors.grey.shade200),
        SizedBox(
          height: size.height * .02,
        ),
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
            keytype: TextInputType.text,
            icon: Icon(EneftyIcons.lock_2_outline),
            controller: pro.passwordController,
            hinttext: "Password",
            type: "Password",
            color: Colors.grey.shade200),
        SizedBox(
          height: size.height * .02,
        ),
        textFormField().textformfield(
            obsc: true,
            maxline: 1,
            keytype: TextInputType.text,
            icon: Icon(EneftyIcons.lock_2_outline),
            controller: pro.confirmPasswordController,
            cnfcontroller: pro.passwordController.text,
            hinttext: "Confirm Password",
            type: "Confirm Password",
            color: Colors.grey.shade200),
      ],
    );
  }
}
