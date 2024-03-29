import 'dart:convert';
import 'dart:io';

import 'package:butcity/core/const/api_urls.dart';
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/features/compilations/data/models/compilation_model.dart';
import 'package:butcity/features/compilations/data/models/compilation_type_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class CompilationDataSource {
  /// my compilation
  Future<List<CompilationModel>> myCompilations({required String token});

  /// all compilation
  Future<List<CompilationModel>> allCompilations({required String token});

  /// get compilation type
  Future<List<CompilationTypeModel>> getCompilationTypes({String? token});

  /// new compilation
  Future<CompilationModel> newCompilation(
      {required String desc,
      required File? image,
      required String lat,
      required String long,
      required String type,
      required String? token});
}

class CompilationDataSourceImpl extends GetConnect
    implements CompilationDataSource {
  @override
  Future<List<CompilationModel>> allCompilations(
      {required String token}) async {
    final response = await get(ApiUrls.allCompilations, headers: {
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
            compilationModel.copyWith(location: location[1].street);
        compilationModels.add(compilationModel);
      }
      return compilationModels;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      return await Future.delayed(
        const Duration(seconds: 2),
        () => allCompilations(token: token),
      );
    }
  }

  @override
  Future<List<CompilationModel>> myCompilations({required String token}) async {
    final response = await get(ApiUrls.myCompilations, headers: {
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
            compilationModel.copyWith(location: location[1].street);
        compilationModels.add(compilationModel);
      }
      return compilationModels;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      return await Future.delayed(
        const Duration(seconds: 2),
        () => myCompilations(token: token),
      );
    }
  }

  @override
  Future<CompilationModel> newCompilation(
      {required String desc,
      required File? image,
      required String lat,
      required String long,
      required String type,
      required String? token}) async {
    if (token == null) {
      throw EmptyCacheException();
    }
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.newCompilation));

    request.fields['description'] = desc;
    request.fields['lat'] = lat;
    request.fields['long'] = long;
    request.fields['type'] = type;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
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
      ApiUrls.compilationType,
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
      return Future.delayed(
        Duration.zero,
        () => getCompilationTypes(token: token),
      );
    }
  }
}
