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
  ProductModel(
      {this.id,
      this.userName,
      required this.productname,
      required this.description,
      required this.price,
      this.image,
      required this.place,
      required this.category,
      required this.wishlist});

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
      'place': place
    };
  }
}
