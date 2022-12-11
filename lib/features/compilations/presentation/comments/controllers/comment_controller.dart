import 'package:butcity/core/const/fields.dart';
import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
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
  late List<Comment> _comment = [];
  List<Comment> get comments => _comment;

  TextEditingController addCommentText = TextEditingController();
  String addCommentTextError = '';

  ScrollController listScrollController = ScrollController();

  onChange(String value) {
    if (value.isNotEmpty) {
      addCommentTextError = '';
      update();
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// get comments
  Future<void> getComments({required String compilationId}) async {
    isLoading = true;
    update();

    final response = await _getCommentUseCase(compilationId: compilationId);

    response.fold((Failure failure) {
      isLoading = false;
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      update();
      ToastManager.showError(failure.message);
    }, (right) {
      _comment = right;
      isLoading = false;
      update();
    });
  }

  /// add comment
  addComment() async {
    addCommentTextError = '';
    isLoading = true;
    update();
    if (addCommentText.text.isEmpty) {
      addCommentTextError = LocaleKeys.addComment.tr;
      update();
    }
    if (addCommentText.text.isNotEmpty) {
      final response = await _addCommentUseCase(
        compilationId: Get.arguments[Fields.complaintId],
        content: addCommentText.text,
      );
      response.fold((failure) {
        isLoading = false;
        update();
        ToastManager.showError(failure.message);
      }, (right) {
        isLoading = false;
        addCommentText.clear();
        getComments(compilationId: Get.arguments[Fields.complaintId]);
        if (listScrollController.hasClients) {
          listScrollController.animateTo(0.0,
              duration: const Duration(microseconds: 500),
              curve: Curves.easeOut);
        }

        update();
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

  /// refresh indicator
  onRefresh() {
    getComments(compilationId: Get.arguments[Fields.complaintId]);
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      compilation = Get.arguments[Fields.compilations];
      getComments(compilationId: Get.arguments[Fields.complaintId]);
    }
    userData();
    super.onInit();
  }
}
