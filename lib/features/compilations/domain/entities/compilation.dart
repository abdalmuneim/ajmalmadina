import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';
import 'package:equatable/equatable.dart';

class Compilation extends Equatable {
  final int? id;
  final int? type;
  final String? description;
  final String? image;
  final String? lat;
  final String? long;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final int? userId;
  final String? imageForWeb;
  final String? location;
  final User? user;
  final CompilationType? types;

  const Compilation({
    this.id,
    this.user,
    this.types,
    this.type,
    this.description,
    this.image,
    this.lat,
    this.long,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.userId,
    this.imageForWeb,
  });
  @override
  List<Object?> get props => [
        id,
        type,
        description,
        image,
        lat,
        long,
        status,
        createdAt,
        updatedAt,
        userId,
        location,
        imageForWeb,
        user,
        types,
      ];
}
