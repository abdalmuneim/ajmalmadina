import 'package:butcity/core/const/api_urls.dart';
import 'package:butcity/core/const/fields.dart';
import 'package:butcity/core/error/exceptions.dart';
import 'package:butcity/features/compilations/data/models/comment_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

abstract class CommentsDataSource {
  /// get comments
  Future<List<CommentModel>> getComments(
      {String? token, required String compilationId});

  /// new comments
  Future<CommentModel> addComment({
    String? token,
    required String compilationId,
    required String content,
  });
}

class CommentDataSourceImpl extends GetConnect implements CommentsDataSource {
  @override
  Future<List<CommentModel>> getComments(
      {String? token, required String compilationId}) async {
    if (token == null) {
      throw EmptyCacheException();
    }

    final Response response = await get(
      ApiUrls.getComments + compilationId,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      List<CommentModel> commentModel = [];
      for (var element in responseBody['data']) {
        commentModel.add(CommentModel.fromMap(element));
      }
      return commentModel;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      return await Future.delayed(
        const Duration(seconds: 2),
        () => getComments(token: token, compilationId: compilationId),
      );
    }
  }

  @override
  Future<CommentModel> addComment({
    String? token,
    required String compilationId,
    required String content,
  }) async {
    Response response = await post(
      ApiUrls.addComments,
      {
        Fields.complaintId: compilationId,
        Fields.content: content,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return CommentModel.fromMap(response.body['data']);
    } else {
      throw ServerException(message: response.body['error']);
    }
  }
}
