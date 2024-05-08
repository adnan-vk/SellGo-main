import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/view/bottom_bar/bottombar.dart';
import 'package:authentication/view/getstart/get_start.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    goToLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo blue.png',
          width: size.width * .6,
        ),
      ),
    );
  }

  goToLogin(context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final UserPrvd =
        Provider.of<AuthenticationProvider>(context, listen: false);

    if (currentUser == null) {
      await Future.delayed(
        Duration(seconds: 2),
      );
      return NavigatorHelper().pushReplacement(
        context: context,
        replacementPage: GetStart(),
      );
    } else {
      CircularProgressIndicator();
      await UserPrvd.getUser();
      await Future.delayed(
        Duration(seconds: 2),
      );
      return NavigatorHelper().pushReplacement(
        context: context,
        replacementPage: BottomBar(),
      );
    }
  }
}
