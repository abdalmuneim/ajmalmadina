import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/compilations/data/models/comment_model.dart';
import 'package:butcity/features/compilations/domain/entities/comment.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/usecases/add_comment_use_case.dart';
import 'package:butcity/features/compilations/domain/usecases/get_comments_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final GetCommentsUseCase _getCommentUseCase;
  final AddCommentsUseCase _addCommentUseCase;
  final GetUserUseCase _getUserUseCase;
  CommentController(
    this._getCommentUseCase,
    this._getUserUseCase,
    this._addCommentUseCase,
  );

  bool isLoading = false;

  Compilation? compilation;
  User? user;
  List<Comment>? _comment = [];
  List<Comment>? get comment => _comment;

  String addCommentText = '';
  String addCommentTextError = '';

  onChange(String value) {
    addCommentText = value;
    if (value.isNotEmpty) {
      addCommentTextError = '';
      update();
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// get comments
  Future<void> getComments({required String compilationId}) async {
    if (comment!.isNotEmpty &&
        compilationId == comment!.first.complaintId.toString()) {
    } else {
      isLoading = true;
      update();
    }

    final response = await _getCommentUseCase(compilationId: compilationId);

    response.fold((l) {
      isLoading = false;
      update();
      if (l.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }

      ToastManager.showError(l.message);
    }, (r) {
      _comment = r;
      isLoading = false;
      update();
    });
  }

  /// add comment
  addComment() async {
    addCommentTextError = '';
    isLoading = true;
    update();
    if (addCommentText.isEmpty) {
      addCommentTextError = LocaleKeys.addComment.tr;
      update();
    }
    if (addCommentText.isNotEmpty) {
      final response = await _addCommentUseCase(
        compilationId: Get.arguments[CommentFields.complaintId],
        content: addCommentText,
      );
      response.fold((l) {
        isLoading = false;
        update();
      },
          (r) => {
                print(r),
                isLoading = false,
                update(),
              });
    }
    isLoading = false;
    update();
  }

  /// get user data
  userData() async {
    var result = await _getUserUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      user = right;
      update();
    });
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      compilation = Get.arguments[CommentFields.content];
      getComments(compilationId: Get.arguments[CommentFields.complaintId]);
    }
      userData();
    super.onInit();
  }
}
