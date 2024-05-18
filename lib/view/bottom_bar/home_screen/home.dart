import 'package:flutter/material.dart';

import '../../../widgets/text_widget.dart';
import 'widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            SizedBox(
              height: size.height * .025,
            ),
            HomeWidgets().topwidget(
              context,
            )
          ],
        ),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .020,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget().text(data: "Categories"),
              ],
            ),
            SizedBox(height: size.height * .015),
            HomeWidgets().categoryAvatarListView(
              context,
            ),
            SizedBox(height: size.height * .015),
            HomeWidgets().productList(context),
          ],
        ),
      ),
    );
  }
}
