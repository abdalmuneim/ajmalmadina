// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String name;
  final String email;
  final String imageForWeb;
  final String createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageForWeb,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        createdAt,
      ];
}
