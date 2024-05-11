// ignore_for_file: must_be_immutable

import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  ProductModel product;
  UpdatePage({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    nameController = TextEditingController(text: widget.product.productname);
    categoryController = TextEditingController(text: widget.product.category);
    descriptionController =
        TextEditingController(text: widget.product.description);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    placeController = TextEditingController(text: widget.product.place);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ItemProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product Details'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            NavigatorHelper().pop(context: context);
          },
          icon: Icon(EneftyIcons.arrow_left_3_outline),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: placeController,
              decoration: InputDecoration(labelText: 'Place'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await pro.startLoading(true);
                await updateProduct(context, widget.product);
                await pro.startLoading(false);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  updateProduct(context, ProductModel product) async {
    final getProvider = Provider.of<ItemProvider>(context, listen: false);

    product.productname = nameController.text;
    product.description = descriptionController.text;
    product.category = categoryController.text;
    product.place = placeController.text;
    product.price = int.tryParse(priceController.text);
    await getProvider.updateProduct(product.id, product);
    Navigator.pop(context);
    Navigator.pop(context);
    snackBarWidget()
        .iconSnackSuccess(context, label: "Product updated successfully");
  }
}
