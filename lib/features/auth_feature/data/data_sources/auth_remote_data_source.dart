import 'dart:io';

import 'package:butcity/core/const/api_urls.dart';
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/core/error/failures.dart';
import 'package:butcity/features/auth_feature/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<UserModel> updateUser({
    required String name,
    required File image,
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
  }) async {
    Response response = await post(
      ApiUrls.urlRegister,
      {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromMap(response.body['data']);
    } else {
      throw ServerException(message: response.body['error']);
    }
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    Response response = await post(
      ApiUrls.urlLogin,
      {
        'email': email,
        'password': password,
      },
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromMap(response.body['data']);
    } else {
      throw ServerException(message: response.body['error']);
    }
  }

  @override
  Future<Unit> logOut({required String token}) async {
    Response response = await post(
      ApiUrls.urlSignOut,
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
  Future<UserModel> updateUser(
      {required String name, required File image}) async {
    Response response = await post(
      ApiUrls.urlRegister,
      {
        'name': name,
        'image': image,
      },
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromMap(response.body['data']);
    } else {
      throw ServerException(message: response.body['error']);
    }
  }
}
