import 'dart:convert';

import 'package:butcity/core/const/fields.dart';
import 'package:butcity/features/compilations/domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    super.id,
    super.complaintId,
    super.userId,
    super.content,
    super.status,
    super.createdAt,
    super.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Fields.id: id,
      Fields.complaintId: complaintId,
      Fields.userId: userId,
      Fields.content: content,
      Fields.status: status,
      Fields.createdAt: createdAt,
      Fields.updatedAt: updatedAt,
    };
  }

  CommentModel copyWith({
    final int? id,
    final int? commentId,
    final int? userId,
    final String? content,
    final int? status,
    final String? createdAt,
    final String? updatedAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      complaintId: commentId ?? complaintId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map[Fields.id] != null ? map[Fields.id] as int : null,
      complaintId: map[Fields.complaintId] != null
          ? map[Fields.complaintId] as int
          : null,
      userId: map[Fields.userId] != null ? map[Fields.userId] as int : null,
      content:
          map[Fields.content] != null ? map[Fields.content] as String : null,
      status: map[Fields.status] != null ? map[Fields.status] as int : null,
      createdAt: map[Fields.createdAt] != null
          ? map[Fields.createdAt] as String
          : null,
      updatedAt: map[Fields.updatedAt] != null
          ? map[Fields.updatedAt] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
