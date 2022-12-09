import 'package:butcity/core/const/fields.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';

class CompilationTypeModel extends CompilationType {
  const CompilationTypeModel({
    super.id,
    super.name,
    super.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Fields.id: id,
      Fields.name: name,
      Fields.status: status,
    };
  }

  factory CompilationTypeModel.fromMap(Map<String, dynamic> map) {
    return CompilationTypeModel(
      id: map[Fields.id] != null ? map[Fields.id] as int : null,
      name: map[Fields.name] != null ? map[Fields.name] as String? : null,
      status: map[Fields.status] != null ? map[Fields.status] as int : null,
    );
  }
}
