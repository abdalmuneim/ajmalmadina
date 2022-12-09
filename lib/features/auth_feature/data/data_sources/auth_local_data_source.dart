// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/features/auth_feature/data/models/user_model.dart';
import 'package:butcity/core/resources/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

abstract class BaseAuthLocalDataSource {
  Future<UserModel> readUser();
  Future<Unit> writeUser({required UserModel user});
  Future<Unit> removeUser();
  Future<String> readToken();

  Future<Unit> writeToken({required String token});
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
      final data = await getStorage.read(AppStrings.USER_STORAGE);
      return Future.value(UserModel.fromJson(data));
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> removeUser() async {
    await getStorage.remove(AppStrings.USER_STORAGE);

    return Future.value(unit);
  }

  @override
  Future<Unit> writeUser({required UserModel user}) async {
    try {
      await getStorage.write(AppStrings.USER_STORAGE, user.toJson());
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> removeToken() async {
    await flutterSecureStorage.delete(key: AppStrings.USER_STORAGE);

    return Future.value(unit);
  }

  @override
  Future<Unit> writeToken({required String token}) async {
    try {
      await flutterSecureStorage.write(
          key: AppStrings.USER_STORAGE, value: token);
      return Future.value(unit);
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<String> readToken() async {
    try {
      final data =
          await flutterSecureStorage.read(key: AppStrings.USER_STORAGE);

      return Future.value(data);
    } catch (e) {
      throw EmptyCacheException();
    }
  }
}
