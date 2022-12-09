import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/repositories/compilation_repository.dart';
import 'package:dartz/dartz.dart';

class AllCompilationsUseCase {
  final CompilationRepository repository;

  AllCompilationsUseCase(this.repository);

  Future<Either<Failure, List<Compilation>>> call() {
    return repository.allCompilations();
  }
}
