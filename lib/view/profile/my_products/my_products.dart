import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/view/profile/my_products/widget/Product_widget.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              NavigatorHelper().pop(context: context);
            },
            icon: Icon(EneftyIcons.arrow_left_3_outline)),
        centerTitle: true,
        title: TextWidget().text(data: "MyProducts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ItemProvider>(
          builder: (context, provider, child) {
            final List<ProductModel> myProducts = filteringMyProduct(provider);
            return myProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: myProducts.length,
                    itemBuilder: (context, index) {
                      final product = myProducts[index];
                      return ProductWidget().productCard(context, product);
                    },
                  )
                : Center(
                    child: Text('No products found.'),
                  );
          },
        ),
      ),
    );
  }

  List<ProductModel> filteringMyProduct(ItemProvider provider) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return [];
    }

    final user = currentUser.email ?? currentUser.phoneNumber;

    List<ProductModel> myProducts = provider.allproducts
        .where((product) => product.userName == user)
        .toList();
    return myProducts;
  }
}
