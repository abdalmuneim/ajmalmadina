import 'dart:convert';

import 'package:butcity/core/const/fields.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.email,
    this.token,
    required super.imageForWeb,
  });

  final String? token;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Fields.id: id,
      Fields.imageForWeb: imageForWeb,
      Fields.name: name,
      Fields.email: email,
      Fields.createdAt: createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[Fields.id] as int,
      name: map[Fields.name] as String,
      email: map[Fields.email] as String,
      imageForWeb: map[Fields.imageForWeb] as String,
      token: map[Fields.token] != null ? map[Fields.token] as String : null,
      createdAt: map[Fields.createdAt] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
