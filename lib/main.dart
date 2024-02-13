import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cleanarch_bloc/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_cleanarch_bloc/features/news/presentation/pages/home/daily_news.dart';
import 'package:news_cleanarch_bloc/inject_app.dart';

import 'config/routes/routes.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        title: 'News Clean Architecture',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        debugShowCheckedModeBanner: false,
        home: const DailyNews(),
      ),
    );
  }
}
