import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:authentication/widgets/textfield_widget.dart';
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
  TextEditingController phoneEditController = TextEditingController();
  @override
  void initState() {
    super.initState();
    firstNameEditController.text = widget.user.firstname ?? "";
    lastNameEditController.text = widget.user.lastname ?? "";
    phoneEditController.text = widget.user.phoneNumber ?? "";
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: ButtonWidget().leadingIcon(context),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  TextWidget().text(
                      data: "Edit User Details",
                      size: 20.0,
                      weight: FontWeight.bold),
                  SizedBox(height: size.height * .03),
                  textFormField().textformfield(
                      maxline: 1,
                      type: 'firstName',
                      controller: firstNameEditController,
                      hinttext: "First Name"),
                  SizedBox(height: size.height * .03),
                  textFormField().textformfield(
                      maxline: 1,
                      controller: lastNameEditController,
                      hinttext: "Last Name"),
                  SizedBox(height: size.height * .03),
                  textFormField().textformfield(
                      type: "phone",
                      max: 10,
                      keytype: TextInputType.phone,
                      controller: phoneEditController,
                      hinttext: "Phone Number"),
                  SizedBox(height: size.height * .03),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        try {
                          updateUser(context, widget.user);
                          Navigator.pop(context);
                          snackBarWidget().iconSnackSuccess(context,
                              label: "Account has been created successfully");
                        } catch (e) {
                          snackBarWidget().iconSnackFail(context,
                              label: "Account not created, try again");
                        }
                      }
                    },
                    child: TextWidget()
                        .text(data: "Update", weight: FontWeight.bold),
                  ),
                ],
              ),
            ),
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
