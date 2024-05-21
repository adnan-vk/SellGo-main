import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/controller/favourites_provider/favourites_controller.dart';
import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/view/details/details.dart';
import 'package:authentication/widgets/navigator_widget.dart';
import 'package:authentication/widgets/text_widget.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class favWidget {
  Widget buildFavouriteItem(context) {
    final size = MediaQuery.of(context).size;
    bool? thisuser;
    return Consumer2<FavouritesProvider, ItemProvider>(
        builder: (context, favvalue, addvalue, child) {
      final favlistItems = checkUser(favvalue, addvalue);
      if (favlistItems.isEmpty) {
        return Center(
          child: TextWidget().text(data: "There is no items in the Favourites"),
        );
      }
      return ListView.builder(
        itemCount: favlistItems.length,
        itemBuilder: (context, index) {
          final item = favlistItems[index];
          return Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (item.id == FirebaseAuth.instance.currentUser!.uid) {
                      thisuser = true;
                    } else {
                      thisuser = false;
                    }
                    NavigatorHelper().push(
                        context: context,
                        page: Details(
                            product: favlistItems[index], thisUser: thisuser)
                        );
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: item.image != null
                                ? NetworkImage(item.image![0]) as ImageProvider
                                : AssetImage('assets/images/dummy image.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: TextWidget().text(
                          data: "${item.productname!.toUpperCase()}",
                          weight: FontWeight.bold),
                      subtitle: TextWidget().text(
                          data: "${item.price}",
                          color: Colors.green,
                          weight: FontWeight.bold),
                      trailing: IconButton(
                        icon: Icon(
                          EneftyIcons.heart_bold,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          final wish = addvalue.favListCheck(item);
                          await addvalue.favouritesClicked(item.id!, wish);
                        },
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                )
              ],
            ),
          );
        },
      );
    });
  }

  List<ProductModel> checkUser(
      FavouritesProvider wishlistProvider, ItemProvider productProvider) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }
    final user = currentUser.email ?? currentUser.phoneNumber;
    List<ProductModel> myProducts = [];
    for (var book in productProvider.allproducts) {
      if (book.wishlist.contains(user)) {
        myProducts.add(book);
      }
    }
    return myProducts;
  }
}
