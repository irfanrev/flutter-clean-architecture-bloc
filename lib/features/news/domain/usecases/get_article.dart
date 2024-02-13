import 'package:news_cleanarch_bloc/core/resources/data_state.dart';
import 'package:news_cleanarch_bloc/core/usecases/usecase.dart';
import 'package:news_cleanarch_bloc/features/news/domain/entities/article_entity.dart';

import '../respository/article_repository.dart';

class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {

  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);
  
  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }

}