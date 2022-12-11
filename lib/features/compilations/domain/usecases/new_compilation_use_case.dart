import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/repositories/compilation_repository.dart';
import 'package:dartz/dartz.dart';

class NewCompilationsUseCase {
  final CompilationRepository repository;

  NewCompilationsUseCase(this.repository);

  Future<Either<Failure, Compilation>> call({
    required String desc,
    required File? image,
    required String lat,
    required String long,
    required String type,
  }) {
    return repository.newCompilation(
        desc: desc, image: image, lat: lat, long: long, type: type);
  }
}
