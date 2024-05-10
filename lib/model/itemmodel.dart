class ProductModel {
  String? userName;
  String? id;
  String? productname;
  String? description;
  int? price;
  String? category;
  List? image;
  String? place;
  List wishlist;
  String? uid;
  ProductModel({
    this.id,
    this.userName,
    required this.productname,
    required this.description,
    required this.price,
    this.image,
    required this.place,
    required this.category,
    required this.wishlist,
    required this.uid,
  });

  factory ProductModel.fromjson(String id, Map<String, dynamic> json) {
    return ProductModel(
      id: id,
      productname: json['name'],
      userName: json['userName'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      image: List<String>.from(json['image']),
      wishlist: List<String>.from(json['wishlist']),
      place: json['place'],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'name': productname,
      'description': description,
      'userName': userName,
      "category": category,
      'price': price,
      'image': image,
      'wishlist': wishlist,
      'place': place,
      "uid": uid,
    };
  }
}
