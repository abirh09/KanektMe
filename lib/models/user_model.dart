// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String name;
  final String authId;
  final bool active;
  final DateTime createdAt;
  final String? profilePictureSmall;
  final String? profilePictureLarge;
  final String country;

  UserModel({
    required this.name,
    required this.authId,
    required this.active,
    required this.createdAt,
    this.profilePictureSmall,
    this.profilePictureLarge,
    required this.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    authId: json["auth_id"],
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    profilePictureSmall: json["profile_picture_small"]??"",
    profilePictureLarge: json["profile_picture_large"]??"",
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "auth_id": authId,
    "active": active,
    "created_at": createdAt.toIso8601String(),
    "profile_picture_small": profilePictureSmall,
    "profile_picture_large": profilePictureLarge,
    "country": country,
  };
}
