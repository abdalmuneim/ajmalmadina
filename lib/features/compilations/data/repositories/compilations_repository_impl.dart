import 'dart:io';

import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/data/data_sources/auth_local_data_source.dart';
import 'package:butcity/features/compilations/data/datasources/compliation_data_source.dart';
import 'package:butcity/features/compilations/data/models/compilation_model.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';
import 'package:butcity/features/compilations/domain/repositories/compilation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class CompilationRepositoryImpl implements CompilationRepository {
  final CompilationDataSource remoteDataSource;
  final BaseAuthLocalDataSource localDataSource;

  CompilationRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<CompilationModel>>> allCompilations() async {
    try {
      final result = await remoteDataSource.allCompilations(
          token: await localDataSource.readToken());

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
  Future<Either<Failure, List<CompilationModel>>> myCompilations() async {
    try {
      final result = await remoteDataSource.myCompilations(
          token: await localDataSource.readToken());

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
  Future<Either<Failure, Compilation>> newCompilation(
      {required String desc,
      required File? image,
      required String lat,
      required String long,
      required String type}) async {
    try {
      final result = await remoteDataSource.newCompilation(
        desc: desc,
        image: image,
        lat: lat,
        long: long,
        type: type,
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

  @override
  Future<Either<Failure, List<CompilationType>>> getCompilationTypes() async {
    try {
      final result = await remoteDataSource.getCompilationTypes(
          token: await localDataSource.readToken());

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
