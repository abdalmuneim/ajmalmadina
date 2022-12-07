import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/comment.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comment>>> getComments(
      {required String compilationId});

  Future<Either<Failure, Comment>> addComment({
    required String complaintId,
    required String content,
  });
}
