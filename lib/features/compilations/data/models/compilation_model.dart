import 'dart:convert';

import 'package:butcity/core/const/fields.dart';
import 'package:butcity/features/auth_feature/data/models/user_model.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/compilations/data/models/compilation_type_model.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';

class CompilationModel extends Compilation {
  const CompilationModel({
    super.id,
    super.type,
    super.description,
    super.image,
    super.lat,
    super.long,
    super.status,
    super.createdAt,
    super.location,
    super.updatedAt,
    super.userId,
    super.imageForWeb,
    super.types,
    super.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Fields.id: id,
      Fields.type: type,
      Fields.description: description,
      Fields.image: image,
      Fields.lat: lat,
      Fields.long: long,
      Fields.status: status,
      Fields.createdAt: createdAt,
      Fields.updatedAt: updatedAt,
      Fields.userId: userId,
      Fields.imageForWeb: imageForWeb,
      Fields.user: user,
      Fields.types: types,
    };
  }

  CompilationModel copyWith({
    int? id,
    int? type,
    String? description,
    String? image,
    String? lat,
    String? long,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? userId,
    String? imageForWeb,
    String? location,
    CompilationType? types,
    User? user,
  }) {
    return CompilationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      imageForWeb: imageForWeb ?? this.imageForWeb,
      location: location ?? this.location,
      user: user ?? this.user,
      types: types ?? this.types,
    );
  }

  factory CompilationModel.fromMap(Map<String, dynamic> map) {
    return CompilationModel(
      id: map[Fields.id] != null ? map[Fields.id] as int : null,
      type: map[Fields.type] != null ? map[Fields.type] as int : null,
      description: map[Fields.description] != null
          ? map[Fields.description] as String
          : null,
      image: map[Fields.image] != null ? map[Fields.image] as String : null,
      lat: map[Fields.lat] != null ? map[Fields.lat] as String : null,
      long: map[Fields.long] != null ? map[Fields.long] as String : null,
      status: map[Fields.status] != null ? map[Fields.status] as int : null,
      createdAt: map[Fields.createdAt] != null
          ? map[Fields.createdAt] as String
          : null,
      updatedAt: map[Fields.updatedAt] != null
          ? map[Fields.updatedAt] as String
          : null,
      userId: map[Fields.userId] != null ? map[Fields.userId] as int : null,
      imageForWeb: map[Fields.imageForWeb] != null
          ? map[Fields.imageForWeb] as String
          : null,
      user:
          map[Fields.user] != null ? UserModel.fromMap(map[Fields.user]) : null,
      types: map[Fields.types] != null
          ? CompilationTypeModel.fromMap(map[Fields.types])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompilationModel.fromJson(String source) =>
      CompilationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
