part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

class MarkFavorite extends BlogEvent {
  final String id;

  const MarkFavorite(this.id);

  @override
  List<Object> get props => [id];
}
