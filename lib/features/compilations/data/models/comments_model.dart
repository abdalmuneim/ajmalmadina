import 'dart:convert';

import 'package:butcity/features/compilations/domain/entities/comments.dart';

class CommentsModel extends Comments {
  const CommentsModel({
    super.id,
    super.description,
    super.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'status': status,
    };
  }

  CommentsModel copyWith({
    int? id,
    String? description,
    int? status,
  }) {
    return CommentsModel(
      id: id ?? this.id,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      id: map['id'] != null ? map['id'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentsModel.fromJson(String source) =>
      CommentsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
