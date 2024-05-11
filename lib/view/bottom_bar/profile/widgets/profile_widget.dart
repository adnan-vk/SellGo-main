import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/bottom_provider/bottom_prov.dart';
import 'package:authentication/view/authentication/signin_screen/sign_in.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget {
  container({text, context, page}) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper().push(context: context, page: page);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget().text(data: text, size: 17.0),
            Icon(EneftyIcons.arrow_right_3_outline)
          ],
        ),
      ),
    );
  }

  logout(context) {
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    final prov = Provider.of<BottomProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget().text(data: "Logout"),
          content: TextWidget().text(data: "Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget().text(data: "Cancel", weight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                pro.signOutEmail();
                pro.googleSignout(); 
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                  (route) => false,
                );
                prov.onTabTapped(0);
              },
              child: TextWidget().text(data: "Logout", weight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
