import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentication/model/authmodel.dart';
import 'package:provider/provider.dart';

class UserEdit extends StatefulWidget {
  final UserModel user;

  UserEdit({Key? key, required this.user}) : super(key: key);

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  // TextEditingController emailEditController = TextEditingController();S
  TextEditingController phoneEditController = TextEditingController();
  @override
  void initState() {
    super.initState();
    firstNameEditController.text = widget.user.firstname ?? "";
    lastNameEditController.text = widget.user.lastname ?? "";
    // emailEditController.text = widget.user.email ?? "";
    phoneEditController.text = widget.user.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              NavigatorHelper().pop(context: context);
            },
            icon: Icon(EneftyIcons.arrow_left_3_outline)),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Edit User Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * .03),
              TextFormField(
                controller: firstNameEditController,
                decoration: InputDecoration(hintText: "First Name"),
              ),
              SizedBox(height: size.height * .03),
              TextFormField(
                controller: lastNameEditController,
                decoration: InputDecoration(hintText: "Last Name"),
              ),
              SizedBox(height: size.height * .03),
              // TextFormField(
              //   controller: emailEditController,
              //   decoration: InputDecoration(hintText: "Email"),
              // ),
              // SizedBox(height: size.height * .03),
              TextFormField(
                controller: phoneEditController,
                decoration: InputDecoration(hintText: "Phone Number"),
              ),
              SizedBox(height: size.height * .03),
              ElevatedButton(
                onPressed: () async {
                  // await pro.startLoading(true);
                  await updateUser(context, widget.user);
                  // await pro.startLoading(false);
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateUser(context, UserModel user) async {
    final pro = Provider.of<ItemProvider>(context, listen: false);
    final getProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    user.firstname = firstNameEditController.text;
    user.lastname = lastNameEditController.text;
    user.phoneNumber = phoneEditController.text;
    await pro.startLoading(true);
    await getProvider.updateUser(FirebaseAuth.instance.currentUser!.uid, user);
    await pro.startLoading(false);
    Navigator.pop(context);
    snackBarWidget()
        .iconSnackSuccess(context, label: "User  updated successfully");
  }
}
