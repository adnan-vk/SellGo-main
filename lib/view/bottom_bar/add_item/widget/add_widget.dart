import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:authentication/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddWidget {
  // void showImagePicker(BuildContext context) {
  //   final pro = Provider.of<ItemProvider>(context, listen: false);
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             ListTile(
  //               leading: Icon(Icons.camera_alt),
  //               title: Text('Take a photo'),
  //               onTap: () {
  //                 pro.getImage();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.image),
  //               title: Text('Choose from gallery'),
  //               onTap: () {
  //                 pro.getImage();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  textfields(context) {
    final pro = Provider.of<ItemProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        textFormField().textformfield(
            keytype: TextInputType.name,
            controller: pro.nameController,
            hinttext: "Product Name",
            color: Colors.grey.shade200),
        SizedBox(height: size.height * .016),
        DropdownButtonFormField(
          value: pro.selectedgroup,
          items: pro.listItems.map((item) {
            return DropdownMenuItem(
              value: item,
              child: TextWidget().text(data: item),
            );
          }).toList(),
          onChanged: (value) {
            pro.selectedgroup = value.toString();
          },
          decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.shade200),
        ),
        SizedBox(height: size.height * .016),
        textFormField().textformfield(
            controller: pro.descriptionController,
            maxline: 3,
            hinttext: "Product Description",
            color: Colors.grey.shade200),
        SizedBox(height: size.height * .016),
        textFormField().textformfield(
            keytype: TextInputType.number,
            controller: pro.priceController,
            hinttext: "Price",
            color: Colors.grey.shade200),
        SizedBox(height: size.height * .016),
        textFormField().textformfield(
            controller: pro.placecontroller,
            keytype: TextInputType.name,
            hinttext: "Place",
            color: Colors.grey.shade200),
      ],
    );
  }
}
