import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_cleanarch_bloc/core/resources/data_state.dart';
import 'package:news_cleanarch_bloc/features/news/data/data_source/local/app_database.dart';
import 'package:news_cleanarch_bloc/features/news/data/data_source/remote/news_api_service.dart';
import 'package:news_cleanarch_bloc/features/news/data/model/article.dart';
import 'package:news_cleanarch_bloc/features/news/domain/entities/article_entity.dart';
import 'package:news_cleanarch_bloc/features/news/domain/respository/article_repository.dart';

import '../../../../core/constants/constants.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
  
  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDAO.getArticles();
  }
  
  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.deleteArticle(ArticleModel.fromEntity(article));
  }
  
  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.insertArticle(ArticleModel.fromEntity(article));
  }
}
