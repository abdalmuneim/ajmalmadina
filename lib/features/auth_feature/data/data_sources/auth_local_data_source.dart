// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/core/resources/app_strings.dart';
import 'package:butcity/features/auth_feature/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:get_storage/get_storage.dart';

abstract class BaseAuthLocalDataSource {
  Future<UserModel> readUser();
  Future<Unit> writeUser({required UserModel user});
  Future<Unit> removeUser();
  Future<String> readToken();

  Future<Unit> writeToken({required String? token});
  Future<Unit> removeToken();
}

class AuthLocalDataSource implements BaseAuthLocalDataSource {
  final GetStorage getStorage;
  final FlutterSecureStorage flutterSecureStorage;

  AuthLocalDataSource({
    required this.getStorage,
    required this.flutterSecureStorage,
  });

  @override
  Future<UserModel> readUser() async {
    try {
      final data = await getStorage.read(AppStrings.userStorage);
      return Future.value(UserModel.fromJson(data));
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> removeUser() async {
    await getStorage.remove(AppStrings.userStorage);

    return Future.value(unit);
  }

  @override
  Future<Unit> writeUser({required UserModel user}) async {
    try {
      await getStorage.write(AppStrings.userStorage, user.toJson());
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> removeToken() async {
    await flutterSecureStorage.delete(key: AppStrings.userStorage);

    return Future.value(unit);
  }

  @override
  Future<Unit> writeToken({required String? token}) async {
    try {
      await flutterSecureStorage.write(
          key: AppStrings.userStorage, value: token);
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<String> readToken() async {
    try {
      final data = await flutterSecureStorage.read(key: AppStrings.userStorage);

      return Future.value(data);
    } catch (e) {
      throw UnauthorizedException();
    }
  }
}
