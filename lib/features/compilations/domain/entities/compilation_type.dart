import 'package:equatable/equatable.dart';

class CompilationType extends Equatable {
  final int? id;
  final String? name;
  final int? status;

  const CompilationType({
    this.id,
    this.name,
    this.status,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        status,
      ];
}
