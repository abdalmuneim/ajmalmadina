import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';

class CompilationTypeModel extends CompilationType {
  const CompilationTypeModel({
    super.id,
    super.name,
    super.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
    };
  }

  factory CompilationTypeModel.fromMap(Map<String, dynamic> map) {
    return CompilationTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String? : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }
}
