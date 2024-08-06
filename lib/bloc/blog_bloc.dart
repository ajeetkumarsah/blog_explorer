import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/repositories/blog_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;

  BlogBloc({required this.blogRepository}) : super(BlogInitial()) {
    on<FetchBlogs>(_onFetchBlogs);

    on<MarkFavorite>(_onMarkFavorite);
  }

  void _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    try {
      emit(BlogLoading());
      final blogs = await blogRepository.fetchBlogs();
      debugPrint('===>BLOC: ${blogs.length}');
      emit(BlogsLoaded(blogs: blogs));
    } catch (e) {
      emit(BlogError(message: e.toString()));
    }
  }

  void _onMarkFavorite(MarkFavorite event, Emitter<BlogState> emit) {
    if (state is BlogsLoaded) {
      final blogs = (state as BlogsLoaded).blogs;
      final updatedBlogs = blogs.map((blog) {
        return blog.id == event.id
            ? Blog(
                id: blog.id,
                title: blog.title,
                imageUrl: blog.imageUrl,
                content: blog.content,
                isFavorite: !blog.isFavorite,
              )
            : blog;
      }).toList();

      emit(BlogsLoaded(blogs: updatedBlogs));
    }
  }
}
