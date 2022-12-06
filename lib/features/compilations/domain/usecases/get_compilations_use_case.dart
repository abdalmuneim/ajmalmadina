import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/repositories/compilation_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompilationsUseCase {
  final CompilationRepository repository;

  GetCompilationsUseCase(this.repository);

  Future<Either<Failure, List<Compilation>>> call() {
    return repository.getCompilations();
  }
}
