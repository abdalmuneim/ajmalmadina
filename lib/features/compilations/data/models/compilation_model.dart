import 'dart:convert';

import 'package:butcity/features/compilations/domain/entities/compilation.dart';

class CompilationModel extends Compilation {
  const CompilationModel(
      {super.id,
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
      super.imageForWeb});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'description': description,
      'image': image,
      'lat': lat,
      'long': long,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_id': userId,
      'image_for_web': imageForWeb,
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
    );
  }

  factory CompilationModel.fromMap(Map<String, dynamic> map) {
    return CompilationModel(
      id: map['id'] != null ? map['id'] as int : null,
      type: map['type'] != null ? map['type'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      lat: map['lat'] != null ? map['lat'] as String : null,
      long: map['long'] != null ? map['long'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      imageForWeb:
          map['image_for_web'] != null ? map['image_for_web'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompilationModel.fromJson(String source) =>
      CompilationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
