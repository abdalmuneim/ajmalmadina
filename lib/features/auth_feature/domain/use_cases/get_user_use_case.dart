import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  GetUserUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call() async {
    return await baseAuthRepository.getUser();
  }
}
