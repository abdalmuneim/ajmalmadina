import 'dart:convert';
import 'dart:io';

import 'package:butcity/core/const/api_urls.dart';
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/features/compilations/data/models/comment_model.dart';
import 'package:butcity/features/compilations/data/models/compilation_model.dart';
import 'package:butcity/features/compilations/data/models/compilation_type_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class CompilationDataSource {
  /// get compilation
  Future<List<CompilationModel>> getCompilations({String? token});

  /// get compilation
  Future<CompilationModel> newCompilation(
      {required String desc,
      required File image,
      required String lat,
      required String long,
      required String type,
      required String? token});

  /// get compilation type
  Future<List<CompilationTypeModel>> getCompilationTypes({String? token});
}

class CompilationDataSourceImpl extends GetConnect
    implements CompilationDataSource {
  @override
  Future<List<CompilationModel>> getCompilations({String? token}) async {
    if (token == null) {
      throw EmptyCacheException();
    }

    final response = await get(ApiUrls.getCompilations, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    final responseBody = response.body; 

    if (response.statusCode == 200) {
      List<CompilationModel> compilationModels = [];
      for (var element in responseBody['data']) {
        CompilationModel compilationModel = CompilationModel.fromMap(element);
        final location = await placemarkFromCoordinates(
            double.tryParse(compilationModel.lat ?? '') ?? 0,
            double.tryParse(compilationModel.long ?? '') ?? 0);
        compilationModel =
            compilationModel.copyWith(location: location[0].country);
        compilationModels.add(compilationModel);
      }
      return compilationModels;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException(message: LocaleKeys.networkFailure.tr);
    }
  }

  @override
  Future<CompilationModel> newCompilation(
      {required String desc,
      required File image,
      required String lat,
      required String long,
      required String type,
      required String? token}) async {
    if (token == null) {
      throw EmptyCacheException();
    }
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.urlNewCompilation));

    request.fields['description'] = desc;
    request.fields['lat'] = lat;
    request.fields['long'] = long;
    request.fields['type'] = type;
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();
    final responseBody = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      return CompilationModel.fromMap(responseBody);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException(message: responseBody['message']);
    }
  }

  @override
  Future<List<CompilationTypeModel>> getCompilationTypes(
      {String? token}) async {
    if (token == null) {
      throw EmptyCacheException();
    }

    final response = await get(
      ApiUrls.urlCompilationType,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    final responseBody = response.body;
    if (response.statusCode == 200) {
      List<CompilationTypeModel> compilationModel = [];
      for (var element in responseBody['data']) {
        compilationModel.add(CompilationTypeModel.fromMap(element));
      }
      return compilationModel;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException(message: responseBody['massage']);
    }
  }
}
