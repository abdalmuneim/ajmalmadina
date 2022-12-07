// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

/* 

            "id": 1,
            "complaint_id": 2,
            "user_id": 2,
            "content": "description description description description",
            "status": 1,
            "created_at": "2022-11-14T14:39:48.000000Z",
            "updated_at": "2022-11-14T14:39:48.000000Z"

 */

class Comment extends Equatable {
  final int? id;
  final int? complaintId;
  final int? userId;
  final String? content;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  const Comment({
    this.id,
    this.complaintId,
    this.userId,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object?> get props => [
        id,
        complaintId,
        userId,
        content,
        status,
        createdAt,
        updatedAt,
      ];
}
