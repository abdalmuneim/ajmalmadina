import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserUpdateUseCase {
  final BaseAuthRepository baseAuthRepository;

  UserUpdateUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String name,
    File? imageForWeb,
    required String password,
    required String confirmPassword,
  }) async {
    return await baseAuthRepository.userUpdate(
      name: name,
      imageForWeb: imageForWeb,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
