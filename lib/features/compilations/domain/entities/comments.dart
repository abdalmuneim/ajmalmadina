import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  final int? id;
  final String? name;
  final int? status;
  final String? description;

  const Comments({
    this.id,
    this.name,
    this.status,
    this.description,
  });
  @override
  List<Object?> get props => [id, name, status, description];
}
