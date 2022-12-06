import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await baseAuthRepository.login(
      email: email,
      password: password,
    );
  }
}
