import 'dart:io';

import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/network/network_info.dart';
import 'package:butcity/features/auth_feature/data/models/user_model.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepository({
    required this.baseAuthRemoteDataSource,
    required this.baseAuthLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
    File? image,
    required String confirmPassword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseAuthRemoteDataSource.register(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            image: image);

        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token);
        return Right(user);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseAuthRemoteDataSource.login(
          email: email,
          password: password,
        );
        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token);

        return Right(user);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      final user = await baseAuthLocalDataSource.readUser();

      return Right(user);
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        String token = await baseAuthLocalDataSource.readToken();
        await baseAuthRemoteDataSource.logOut(token: token);
        await baseAuthLocalDataSource.removeUser();
        await baseAuthLocalDataSource.removeToken();

        return const Right(unit);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message));
      }
    } else {
      return const Left(NetworkFailure(message: LocaleKeys.networkFailure));
    }
  }

  @override
  Future<Either<Failure, UserModel>> userUpdate({
    required String name,
    File? image,
    required String password,
    required String confirmPassword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await baseAuthRemoteDataSource.userUpdate(
          name: name,
          image: image,
          token: await baseAuthLocalDataSource.readToken(),
          password: password,
          confirmPassword: confirmPassword,
        );
        await baseAuthLocalDataSource.writeUser(user: user);
        await baseAuthLocalDataSource.writeToken(token: user.token);
        return Right(user);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
