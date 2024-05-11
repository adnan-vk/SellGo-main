import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/bottom_bar/favourites/favourites.dart';
import 'package:authentication/view/bottom_bar/profile/my_products/my_products.dart';
import 'package:authentication/view/bottom_bar/profile/help_and_support/help_support.dart';
import 'package:authentication/view/bottom_bar/profile/useredit/useredit.dart';
import 'package:authentication/view/bottom_bar/profile/widgets/profile_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseauth = FirebaseAuth.instance.currentUser;
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<AuthenticationProvider>(context, listen: false);
    // pro.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              ProfileWidget().logout(context);
            },
            icon: Icon(EneftyIcons.logout_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: firebaseauth!.photoURL != null
                        ? NetworkImage(FirebaseAuth
                            .instance.currentUser!.photoURL
                            .toString())
                        : AssetImage('') as ImageProvider,
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 20,
                      child: Icon(
                        EneftyIcons.edit_bold,
                        color: Colors.white,
                      ))
                ],
              ),
              SizedBox(
                height: size.height * .05,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * .64,
                          child: TextWidget().text(
                              data:
                                  "${pro.currentUser?.firstname!.toUpperCase()} ${pro.currentUser?.lastname!.toUpperCase()}",
                              size: size.width * .06,
                              weight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  UserEdit(user: pro.currentUser!),
                            );
                          },
                          child: TextWidget().text(
                              data: "Edit",
                              color: colors().blue,
                              weight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * .015),
                    TextWidget().text(
                      data: "Email : ${pro.currentUser?.email.toString()}",
                      size: size.width * .04,
                    ),
                    SizedBox(height: size.height * .015),
                    TextWidget().text(
                      data: "Phone : ${pro.currentUser?.phoneNumber ?? " "}",
                      size: size.width * .042,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              ProfileWidget().container(
                  context: context, page: Favourites(), text: "Favourites"),
              SizedBox(
                height: size.height * .03,
              ),
              ProfileWidget().container(text: "Payments"),
              SizedBox(
                height: size.height * .03,
              ),
              ProfileWidget().container(
                  page: MyProducts(), context: context, text: "My Products"),
              SizedBox(
                height: size.height * .03,
              ),
              ProfileWidget().container(
                  text: "Help and support",
                  page: HelpSupport(),
                  context: context),
              SizedBox(
                height: size.height * .03,
              ),
              TextWidget().text(data: "v 1.0.1", size: size.width * .03)
            ],
          ),
        ),
      ),
    );
  }
}
