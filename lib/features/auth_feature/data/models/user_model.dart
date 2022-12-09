import 'dart:convert';

import 'package:butcity/features/auth_feature/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.email,
    required this.token,
    required super.imageForWeb,
  });

  final String token;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_for_web': imageForWeb,
      'name': name,
      'email': email,
      'created_at': createdAt,
      'token': ''
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      imageForWeb: map['image_for_web'] as String,
      token: map['token'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
