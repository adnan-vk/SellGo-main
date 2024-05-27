import 'package:authentication/widgets/navigator_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

import '../../../widgets/circleavatar_widget.dart';
import '../../../widgets/text_widget.dart';

class CallingPage extends StatelessWidget {
  const CallingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .25,
            ),
            TextWidget().text(data: "Connecting..."),
            SizedBox(
              height: size.height * .07,
            ),
            circleavatar().circleAvatar(context: context, radius: 100.0),
            SizedBox(height: size.height * .03),
            TextWidget()
                .text(data: "John Doe", size: 24.0, weight: FontWeight.bold),
            SizedBox(height: size.height * .13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    EneftyIcons.volume_mute_outline,
                    size: 35,
                  ),
                ),
                SizedBox(
                  height: size.height * .060,
                  width: size.width * .60,
                  child: IconButton(
                    onPressed: () {
                      NavigatorHelper().pop(context: context);
                    },
                    icon: Icon(Icons.call_end),
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                    ), 
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
