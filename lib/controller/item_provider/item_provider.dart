import 'dart:developer';
import 'dart:io';

import 'package:authentication/model/itemmodel.dart';
import 'package:authentication/service/item_service/item_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemProvider extends ChangeNotifier { 
  List listItems = [
    "Computer",
    "MobilePhones",
    "Electronics",
    "HomeAppliances",
    "Vehicles",
    "Jobs",
    "Others"
  ];
  String? selectedgroup;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();

  ItemService productservice = ItemService();
  bool isLoading = false;
  File? pickedImage;
  List<ProductModel> allproducts = [];
  List<ProductModel> searchlist = [];
  List<String> downloadUrls = [];
  List<String> imagePaths = [];
  String imageNamePrefix = DateTime.now().microsecondsSinceEpoch.toString();
  Reference? reference;

  String? selectedCategory;
  List<File> productImages = [];

  changecatogery(value) {
    selectedCategory = value;
    notifyListeners();
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      productImages.clear();
      productImages.addAll(
        pickedImages.map(
          (image) => File(image.path),
        ),
      );
      pickedImage = productImages.first;
      notifyListeners();
    }
  }

  addProduct(ProductModel data) async {
    await productservice.addProduct(data);
    clearControllers();
    downloadUrls.clear();
    getProduct();
  }

  void getProduct() async {
    allproducts = await productservice.getAllProducts();
    notifyListeners();
  }

  search(String value) {
    searchlist = allproducts
        .where(
          (element) => element.productname!.toLowerCase().contains(
                value.toLowerCase(),
              ),
        )
        .toList();
    notifyListeners();
  }

  uploadImages() async {
    if (productImages.isNotEmpty) {
      try {
        for (final element in productImages) {
          Reference videoReference = await productservice.uploadImages(element);
          String downloadUrl = await videoReference.getDownloadURL();
          String Path = await videoReference.fullPath;
          imagePaths.add(Path);
          downloadUrls.add(downloadUrl);
          log('File successfully uploaded to Firebase Storage. Download URL: $downloadUrl');
        }
        productImages.clear();
      } catch (e) {
        log('Error uploading files: $e');
      }
    } else {
      log('No files selected.');
    }
  }

  clearControllers() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    productImages.clear();
    placecontroller.clear();
    notifyListeners();
  }

  Future<void> favouritesClicked(String id, bool status) async {
    await productservice.favListClicked(id, status);
    notifyListeners();
  }

  bool favListCheck(ProductModel product) {
    final currentuser = FirebaseAuth.instance.currentUser;
    final user = currentuser?.email ?? currentuser?.phoneNumber;
    return !product.wishlist.contains(user);
  }

  startLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  deleteProduct(productid) async {
    await productservice.deleteProduct(productid);
    notifyListeners();
    getProduct();
  }

  updateProduct(productid, ProductModel data) async {
    await productservice.updateproduct(productid, data);
    clearControllers();
    notifyListeners();
  }

  loadDataForUpdate(ProductModel product) {
    nameController = TextEditingController(text: product.productname);
    descriptionController = TextEditingController(text: product.description);
    priceController = TextEditingController(text: product.price.toString());
    categorycontroller = TextEditingController(text: product.category);
    placecontroller = TextEditingController(text: product.place);
  }
}
