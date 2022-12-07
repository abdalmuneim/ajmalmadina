import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/comment.dart';
import 'package:butcity/features/compilations/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

class AddCommentsUseCase {
  final CommentsRepository repository;

  AddCommentsUseCase(this.repository);

  Future<Either<Failure, Comment>> call({
    required String compilationId,
    required String content,
  }) {
    return repository.addComment(complaintId: compilationId, content: content);
  }
}
