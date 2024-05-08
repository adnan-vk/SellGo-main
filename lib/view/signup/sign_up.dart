import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/signin_screen/sign_in.dart';
import 'package:authentication/view/signup/widgets/signup_widgets.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AuthenticationProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                IconButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.pop(context);
                    pro.clearControllers();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                TextWidget().text(
                    data: "Create an Account",
                    size: size.width * .08,
                    weight: FontWeight.bold),
                const SizedBox(
                  height: 20,
                ),
                signupWidget().textfields(context: context),
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
                            pro.signUpEmail(pro.emailController.text,
                                pro.passwordController.text);
                            await pro.addUser();
                            Navigator.pop(context);
                            snackBarWidget().iconSnackSuccess(context,
                                label: "Account has been created successfully");
                            pro.clearControllers();
                          } catch (e) {
                            snackBarWidget().iconSnackFail(context,
                                label: "Account not created, try again");
                          }
                        }
                      },
                      label: TextWidget()
                          .text(data: "SignUp", color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWidget().text(
                        data: "Already have an Account? ",
                        color: Colors.grey,
                        size: size.width * .025),
                    ButtonWidget().textbutton(
                      text: "Login",
                      weight: FontWeight.bold,
                      context: context,
                      pushpage: SignIn(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
