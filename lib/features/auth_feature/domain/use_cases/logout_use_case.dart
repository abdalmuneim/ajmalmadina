import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/domain/repositories/base_auth_repository.dart';
import 'package:dartz/dartz.dart';
class LogOutUseCase {
  final BaseAuthRepository baseAuthRepository;

  LogOutUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> call() async {
    return await baseAuthRepository.logOut();
  }
}
