import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/theme/colors.dart';
import 'package:authentication/view/add_item/widget/add_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AddItem extends StatelessWidget {
  AddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<ItemProvider>(context);
    return pro.isLoading
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: colors().blue, size: 40),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: TextWidget().text(data: "Add Item", color: colors().black),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget().text(
                        data: "Add Product Images",
                        size: size.width * .0423,
                        weight: FontWeight.bold),
                    SizedBox(height: 16),
                    Container(
                      height: 120,
                      child: Consumer<ItemProvider>(
                        builder: (context, value, child) => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.productImages.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (index == value.productImages.length) {
                                  pro.getImage();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                  image: index < value.productImages.length
                                      ? DecorationImage(
                                          image: FileImage(
                                            value.productImages[index],
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: index == value.productImages.length
                                    ? Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.grey[600],
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    AddWidget().textfields(context),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget().text(
                              data: "Allow Your Location",
                              color: colors().blue),
                          Icon(
                            EneftyIcons.location_bold,
                            size: 15,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: double.infinity,
                        child: FloatingActionButton.extended(
                            elevation: 0,
                            backgroundColor: colors().blue,
                            onPressed: () async {
                              await pro.startLoading(true);
                              await pro.uploadImages();
                              await addData(context);
                              await pro.startLoading(false);
                              snackBarWidget().topsnackBar(context,
                                  message:
                                      "Good job, your Item is Added Successfully");
                            },
                            label: TextWidget()
                                .text(data: "Add Item", color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  addData(context) async {
    final getProvider = Provider.of<ItemProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    if (getProvider.pickedImage != null) {
      await getProvider.uploadImages();

      final product = ProductModel(
        userName: user!.email ?? user.phoneNumber,
        productname: getProvider.nameController.text,
        description: getProvider.descriptionController.text,
        price: int.tryParse(getProvider.priceController.text),
        category: getProvider.selectedgroup,
        wishlist: [],
        image: getProvider.downloadUrls,
        place: getProvider.placecontroller.text,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      getProvider.addProduct(product);
      getProvider.clearControllers();
      getProvider.productImages.clear();
    } else {
      print('Error: pickedImage is null');
    }
  }
}
