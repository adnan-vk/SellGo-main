class UserModel {
  String? uId;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? image;

  UserModel(
      {required this.email,
      required this.firstname,
      this.lastname,
      this.phoneNumber,
      this.uId,
      this.image});

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        phoneNumber: json['phoneNumber'],
        uId: json['userId'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phoneNumber': phoneNumber,
      'userId': uId,
      'image': image
    };
  }
}
