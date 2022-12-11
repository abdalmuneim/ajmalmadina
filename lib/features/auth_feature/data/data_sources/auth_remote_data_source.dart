import 'dart:convert';
import 'dart:io';

import 'package:butcity/core/const/api_urls.dart';
import 'package:butcity/core/const/fields.dart';
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/features/auth_feature/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    File? image,
    required String confirmPassword,
  });
  Future<UserModel> userUpdate({
    required String name,
    required String token,
    File? image,
    required String password,
    required String confirmPassword,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<Unit> logOut({required String token});
}

class AuthRemoteDataSource extends GetConnect
    implements BaseAuthRemoteDataSource {
  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    File? image,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.register));

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = confirmPassword;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    var headers = {
      'Accept': 'application/json',
    };
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();
    final responseBody = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      return UserModel.fromMap(responseBody['data']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException(message: responseBody['message']);
    }
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    Response response = await post(
      ApiUrls.login,
      {
        'email': email,
        'password': password,
      },
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromMap(response.body[Fields.data]);
    } else {
      throw ServerException(message: response.body[Fields.message]);
    }
  }

  @override
  Future<Unit> logOut({required String token}) async {
    Response response = await post(
      ApiUrls.signOut,
      {},
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: response.body['error']);
    }
  }

  @override
  Future<UserModel> userUpdate({
    required String token,
    required String name,
    File? image,
    required String password,
    required String confirmPassword,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.updateUser));

    request.fields['name'] = name;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = confirmPassword;
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
      return UserModel.fromMap(responseBody['data']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException(message: responseBody['message']);
    }
  }
}
