import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/view/profile/my_products/widget/edit_page.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget {
  productCard(context, ProductModel product) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        NavigatorHelper().push(
            context: context,
            page: UpdatePage(
              product: product,
            ));
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 7),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: product.image != null
                        ? NetworkImage("${product.image![0]}") as ImageProvider
                        : AssetImage('assets/images/dummy image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget().text(
                            data: product.productname ?? "",
                            size: 16.0,
                            weight: FontWeight.bold),
                        IconButton(
                          icon: Icon(
                            EneftyIcons.bag_bold,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteWidget(context, product.id);
                          },
                        ),
                      ],
                    ),
                    TextWidget().text(data: product.category ?? "", size: 14.0),
                    SizedBox(height: 8),
                    TextWidget().text(
                        data: "${product.price}",
                        size: 16.0,
                        color: Colors.green,
                        weight: FontWeight.bold),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteWidget(context, product) {
    final pro = Provider.of<ItemProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextWidget().text(data: "Confirm Delete"),
        content: TextWidget()
            .text(data: "Are you sure you want to delete this product?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget().text(data: "Cancel")),
          TextButton(
            onPressed: () {
              pro.deleteProduct(product);
              Navigator.of(context).pop();
              snackBarWidget().iconSnackSuccess(context,
                  label: "The Product Deleted Successfully");
            },
            child: TextWidget().text(data: "Delete"),
          ),
        ],
      ),
    );
  }
}
