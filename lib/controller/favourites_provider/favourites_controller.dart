import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/service/item_service/item_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouritesProvider extends ChangeNotifier {
  ItemService productService = ItemService();

  Future<void> wishlistCliscked(String id, bool status) async {
    await productService.favListClicked(id, status);
    notifyListeners();
  }

  bool wishlistCheck(ProductModel book) {
    final currentuser = FirebaseAuth.instance.currentUser;
    final user = currentuser!.email ?? currentuser.phoneNumber;
    return !book.wishlist.contains(user);
  }
}
