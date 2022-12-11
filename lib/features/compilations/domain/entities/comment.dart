import 'package:equatable/equatable.dart';

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
