import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String firebaseId;
  String fullName;
  String imageUrl;

  UserModel({
    this.firebaseId,
    this.fullName,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firebaseId: json["firebaseId"],
      fullName: json["fullName"],
      imageUrl: json["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firebaseId": firebaseId,
        "fullName": fullName,
        "imageUrl": imageUrl,
      };
}
