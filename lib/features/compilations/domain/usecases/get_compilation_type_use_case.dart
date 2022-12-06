import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';
import 'package:butcity/features/compilations/domain/repositories/compilation_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompilationTypeUseCase {
  final CompilationRepository repository;

  GetCompilationTypeUseCase(this.repository);

  Future<Either<Failure, List<CompilationType>>> call() {
    return repository.getCompilationTypes();
  }
}
