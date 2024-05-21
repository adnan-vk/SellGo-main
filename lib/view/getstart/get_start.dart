import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/authentication/signin_screen/sign_in.dart';
import 'package:flutter/material.dart';

import '../../widgets/botton_widget.dart';
import '../../widgets/text_widget.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors().blue,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * .02,
                  ),
                  TextWidget()
                      .text(data: "\"Give a Second Life To Loved", size: 20.0),
                  TextWidget().text(data: "Treasures\"", size: 20.0),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget().elevatedbutton(
                        page: SignIn(),
                        context: context,
                        text: "Lets Get Started",
                        textcolor: Colors.white,
                        color: colors().blue),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/images/home scrren-portrait.png'),
              width: size.width * .7,
              height: size.height * .6,
            ),
          ),
        ],
      ),
    );
  }
}