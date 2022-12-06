import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  UpdateUserUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String name,
    required File image,
  }) async {
    return await baseAuthRepository.updateUser(
      name: name,
      image: image,
    );
  }
}
