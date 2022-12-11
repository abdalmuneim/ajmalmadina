import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';
import 'package:dartz/dartz.dart';

abstract class CompilationRepository {
  Future<Either<Failure, List<Compilation>>> myCompilations();
  Future<Either<Failure, List<Compilation>>> allCompilations();
  Future<Either<Failure, List<CompilationType>>> getCompilationTypes();
  Future<Either<Failure, Compilation>> newCompilation({
    required String desc,
    required File? image,
    required String lat,
    required String long,
    required String type,
  });
}
