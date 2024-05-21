import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/view/details/details.dart';
import 'package:authentication/widgets/botton_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  final String category;
  const Category({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int crossAxisCount = (size.width / 150).floor();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget().text(data: category),
        automaticallyImplyLeading: false,
        leading: ButtonWidget().leadingIcon(context),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(18),
        child: Consumer<ItemProvider>(
          builder: (context, value, child) {
            final filteredProducts = value.allproducts
                .where((item) => item.category == category)
                .toList();
            return filteredProducts.isNotEmpty
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          bool? thisuser;
                          if (product.id ==
                              FirebaseAuth.instance.currentUser!.uid) {
                            thisuser = true;
                          } else {
                            thisuser = false;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  thisUser: thisuser!,
                                  product: product,
                                ),
                              ));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                        image: product.image != null
                                            ? NetworkImage(
                                                    "${product.image![0]}")
                                                as ImageProvider
                                            : AssetImage(
                                                'assets/images/dummy image.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .005,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: TextWidget().text(
                                              data: "₹ ${product.price}",
                                              size: 20.0,
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                          Consumer<ItemProvider>(
                                            builder:
                                                (context, provalue, child) =>
                                                    GestureDetector(
                                              onTap: () async {
                                                final wish =
                                                    value.favListCheck(product);
                                                await value.favouritesClicked(
                                                    product.id!, wish);
                                              },
                                              child: value.favListCheck(product)
                                                  ? Icon(
                                                      EneftyIcons.heart_outline,
                                                      color: Colors.red,
                                                    )
                                                  : Icon(
                                                      EneftyIcons.heart_bold,
                                                      color: Colors.red,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextWidget().text(
                                      data: product.productname,
                                      size: 13.0,
                                    ),
                                    SizedBox(height: size.height * .005),
                                    TextWidget().text(
                                        data: product.place,
                                        size: 11.0,
                                        color: Colors.grey,
                                        weight: FontWeight.bold),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: TextWidget().text(data: "No Data Found"));
          },
        ),
      ),
    );
  }
}
