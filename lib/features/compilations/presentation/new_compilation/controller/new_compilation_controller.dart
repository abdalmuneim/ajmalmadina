import 'dart:async';
import 'dart:io';

import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/utils/image_pic.dart';
import 'package:butcity/features/compilations/domain/entities/compilation_type.dart';
import 'package:butcity/features/compilations/domain/usecases/get_compilation_type_use_case.dart';
import 'package:butcity/features/compilations/domain/usecases/new_compilation_use_case.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NewCompilationController extends GetxController {
  NewCompilationsUseCase newCompilationsUseCase;
  GetCompilationTypeUseCase getCompilationTypeUseCase;

  NewCompilationController({
    required this.newCompilationsUseCase,
    required this.getCompilationTypeUseCase,
  });

  final TextEditingController descriptionCtr = TextEditingController();

  String imageError = '';
  String typeError = '';
  String locationError = '';
  bool isLoading = false;

  /// on change descriptions
  onChangePhoto(File img) {
    if (imageError.isNotEmpty) {
      imageError = '';
      update();
    }
  }

  /// add new compilation
  addCompilation() async {
    isLoading = true;
    update();

    if (_image == null) {
      imageError = LocaleKeys.noImage.tr;
      isLoading = false;
      update();
    }
    if (selectedCompilationType == null) {
      isLoading = false;
      typeError = 'برجاء اختيار نوع الشكوى';
      update();
    }
    if (lat.isEmpty && long.isEmpty) {
      isLoading = false;
      locationError = LocaleKeys.locationError.tr;
      update();
    }
    if (descriptionCtr.text.isNotEmpty &&
        imageError.isEmpty &&
        long.isNotEmpty &&
        lat.isNotEmpty) {
      locationError = '';
      final response = await newCompilationsUseCase(
        desc: descriptionCtr.text,
        image: image,
        lat: lat,
        long: long,
        type: selectedCompilationType!.id.toString(),
      );
      response.fold((failure) {
        isLoading = false;
        update();
        return ToastManager.showError(failure.message);
      }, (right) {
        isLoading = false;
        update();
        Get.back();
        ToastManager.showSuccess('لقد تم اضافة شكوي بنجاح!');
      });
    }
  }

  File? _image;

  File? get image => _image;

  getImage() async {
    FocusManager.instance.primaryFocus?.unfocus();
    _image = await ImagePic.showBottomSheetPic();
    if (_image != null) {
      imageError = '';
      update();
    }
    update();
  }

  List<CompilationType> compilationTypes = [];

  Future getCompilationsType() async {
    final response = await getCompilationTypeUseCase();

    response.fold(
      (failure) {
        ToastManager.showError(failure.message);
      },
      (right) {
        compilationTypes = right;
        update();
      },
    );
  }

  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  Position? position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  Future<Position?> determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (await Permission.location.isPermanentlyDenied) {
        } else {
          final result = await Permission.location.request();

          serviceEnabled = result == PermissionStatus.granted;
        }
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ToastManager.showError('يجب تفعيل الموقع');

        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (error) {
      rethrow;
    }
  }

  getLocation() async {
    position = await determinePosition();
    if (position != null) {
      long = position!.longitude.toString();
      lat = position!.latitude.toString();
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    update();
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        long = position.longitude.toString();
        lat = position.latitude.toString();
        update();
      },
    );
  }

  @override
  void onInit() async {
    await getCompilationsType();
    getLocation();
    super.onInit();
  }

  CompilationType? selectedCompilationType;

  selectCompilationType(value) {
    selectedCompilationType = value;
    typeError = '';
    update();
  }
}
