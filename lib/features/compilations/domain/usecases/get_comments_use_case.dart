import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/comment.dart';
import 'package:butcity/features/compilations/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommentsUseCase {
  final CommentsRepository repository;

  GetCommentsUseCase(this.repository);

  Future<Either<Failure, List<Comment>>> call({required String compilationId}) {
    return repository.getComments(compilationId: compilationId);
  }
}
