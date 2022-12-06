import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await baseAuthRepository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
