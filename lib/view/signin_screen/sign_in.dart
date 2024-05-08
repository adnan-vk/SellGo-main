import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/bottom_bar/bottombar.dart';
import 'package:authentication/view/signin_screen/widgets/signin_widgets.dart';
import 'package:authentication/view/signup/sign_up.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextWidget().text(
                    data: "Sign in",
                    size: size.width * .1,
                    weight: FontWeight.bold),
                const SizedBox(
                  height: 20,
                ),
                signinWidgets().textfields(context),
                SizedBox(
                  height: size.height * .03,
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    child: FloatingActionButton.extended(
                      backgroundColor: colors().blue, 
                      elevation: 3,
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          try {
                            await pro.signInEmail(pro.emailController.text,
                                pro.passwordController.text);
                            snackBarWidget().iconSnackSuccess(context,
                                label: "User logged in successfully");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomBar(),
                              ),
                              (route) => false,
                            );
                            pro.emailController.clear();
                            pro.passwordController.clear();
                          } catch (e) {
                            snackBarWidget().iconSnackFail(context,
                                label: "Email or password incorrect,Try Again");
                          }
                        }
                        return;
                      },
                      label:
                          TextWidget().text(data: "Login", color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWidget().text(
                        data: "Dont have an Account? ",
                        color: Colors.grey,
                        size: size.width * .025),
                    ButtonWidget().textbutton(
                        weight: FontWeight.bold,
                        text: "Create Account",
                        pushpage: SignUp(),
                        context: context)
                  ],
                ),
                SizedBox(height: size.height * .07),
                signinWidgets().cardwidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
