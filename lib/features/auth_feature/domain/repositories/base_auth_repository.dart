import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required File imageForWeb,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> userUpdate({
    required String name,
    File? imageForWeb,
    required String password,
    required String confirmPassword,
  });
  Future<Either<Failure, Unit>> logOut();
}
