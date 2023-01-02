import 'dart:io';

import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/data/data_sources/auth_local_data_source.dart';
import 'package:butcity/features/compilations/data/datasources/comment__data_source.dart';
import 'package:butcity/features/compilations/data/models/comment_model.dart';
import 'package:butcity/features/compilations/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsDataSource remoteDataSource;
  final BaseAuthLocalDataSource localDataSource;

  CommentsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<CommentModel>>> getComments(
      {required String compilationId}) async {
    try {
      final result = await remoteDataSource.getComments(
          token: await localDataSource.readToken(),
          compilationId: compilationId);

      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    } on SocketException {
      return const Left(ConnectionFailure());
    } on UnauthorizedException {
      localDataSource.removeToken();
      localDataSource.removeUser();
      return const Left(UnAuthenticatedFailure());
    }
  }

  @override
  Future<Either<Failure, CommentModel>> addComment(
      {required String complaintId, required String content}) async {
    try {
      final result = await remoteDataSource.addComment(
        content: content,
        compilationId: complaintId,
        token: await localDataSource.readToken(),
      );

      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    } on SocketException {
      return const Left(ConnectionFailure());
    } on UnauthorizedException {
      localDataSource.removeToken();
      localDataSource.removeUser();
      return const Left(UnAuthenticatedFailure());
    }
  }
}
