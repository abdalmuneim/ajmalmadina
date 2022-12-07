import 'dart:convert';

import 'package:butcity/features/compilations/domain/entities/comment.dart';

class CommentFields {
  static const String id = "id";
  static const String userId = "user_id";
  static const String complaintId = "complaint_id";
  static const String content = "content";
  static const String status = "status";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
}

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
      CommentFields.id: id,
      CommentFields.complaintId: complaintId,
      CommentFields.userId: userId,
      CommentFields.content: content,
      CommentFields.status: status,
      CommentFields.createdAt: createdAt,
      CommentFields.updatedAt: updatedAt,
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
      id: map[CommentFields.id] != null ? map[CommentFields.id] as int : null,
      complaintId: map[CommentFields.complaintId] != null
          ? map[CommentFields.complaintId] as int
          : null,
      userId: map[CommentFields.userId] != null
          ? map[CommentFields.userId] as int
          : null,
      content: map[CommentFields.content] != null
          ? map[CommentFields.content] as String
          : null,
      status: map[CommentFields.status] != null
          ? map[CommentFields.status] as int
          : null,
      createdAt: map[CommentFields.createdAt] != null
          ? map[CommentFields.createdAt] as String
          : null,
      updatedAt: map[CommentFields.updatedAt] != null
          ? map[CommentFields.updatedAt] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
