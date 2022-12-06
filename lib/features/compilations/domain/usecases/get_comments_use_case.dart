import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/comments.dart';
import 'package:butcity/features/compilations/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

class CommentsUseCase {
  final CommentsRepository repository;

  CommentsUseCase(this.repository);

  Future<Either<Failure, Comments>> call({
    required String desc,
  }) {
    return repository.newComments(
      desc: desc,
    );
  }
}
