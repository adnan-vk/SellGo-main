import 'dart:developer';
import 'dart:io';

import 'package:authentication/model/itemmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ItemService {
  String Product = 'product';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<ProductModel> product;
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ImagePicker imagePicker = ImagePicker();
  List<String> downloadUrls = [];

  ItemService() {
    product = firestore.collection(Product).withConverter<ProductModel>(
      fromFirestore: (snapshot, options) {
        return ProductModel.fromjson(
          snapshot.id,
          snapshot.data()!,
        );
      },
      toFirestore: (value, options) {
        return value.tojson();
      },
    );
  }

  Future<void> addProduct(ProductModel data) async {
    try {
      await product.add(data);
    } catch (e) {
      log('Error adding post :$e');
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await product.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> addToCart(String id, String userId) async {
    try {
      await product.doc(id).update(
        {
          'cart': FieldValue.arrayUnion([userId])
        },
      );
    } catch (e) {
      log("Error adding to cart: $e");
    }
  }

  Future<void> favListClicked(String id, bool status) async {
    try {
      if (status == true) {
        await product.doc(id).update(
          {
            'wishlist': FieldValue.arrayUnion(
              [
                firebaseAuth.currentUser!.email ??
                    firebaseAuth.currentUser!.phoneNumber
              ],
            )
          },
        );
      } else {
        await product.doc(id).update(
          {
            'wishlist': FieldValue.arrayRemove(
              [
                firebaseAuth.currentUser!.email ??
                    firebaseAuth.currentUser!.phoneNumber
              ],
            )
          },
        );
      }
    } catch (e) {
      log("error is $e");
    }
  }

  uploadImages(file, {String? filePath}) async {
    String fileName = await DateTime.now().millisecondsSinceEpoch.toString();
    try {
      Reference fileFolder = storage.child('Item Image').child('$fileName');

      if (filePath != null) {
        Reference deletefile = storage.child(filePath);
        await deletefile.delete();
        log('The current file Successfully deleted from Firebase Storage.');
      }
      await fileFolder.putFile(file);
      log('file successfully uploaded to Firebase Storage.');
      return fileFolder;
    } catch (e) {
      throw 'Error in Update profile pic : $e';
    }
  }

  deleteProduct(productid) async {
    try {
      await product.doc(productid).delete();
      log("The product idd deleted");
    } catch (e) {
      log("the product is not deletd $e");
    }
  }

  updateproduct(productid, ProductModel data) async {
    try {
      await product.doc(productid).update(data.tojson());
    } catch (e) {
      log("error in updating product : $e");
    }
  }
}
