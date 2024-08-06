import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/repositories/blog_repository.dart';
import 'package:blog_explorer/screens/blog_list_screen.dart';
import 'package:blog_explorer/utils/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  await Hive.openBox<Blog>('blogs');
  final ApiClient apiClient = ApiClient();
  final BlogRepository blogRepository = BlogRepository(apiClient: apiClient);

  runApp(MyApp(blogRepository: blogRepository));
}

class MyApp extends StatelessWidget {
  final BlogRepository blogRepository;

  const MyApp({Key? key, required this.blogRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home: BlocProvider(
        create: (context) => BlogBloc(blogRepository: blogRepository),
        child: BlogListScreen(),
      ),
    );
  }
}
