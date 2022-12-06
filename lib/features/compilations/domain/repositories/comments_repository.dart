import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/comments.dart'; 
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comments>>> getComments();
  Future<Either<Failure, Comments>> newComments({
    required String desc,
  }); 
}
