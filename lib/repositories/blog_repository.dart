import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/utils/api_client.dart';
import 'package:hive/hive.dart';

class BlogRepository {
  final ApiClient apiClient;
  final Box<Blog> blogBox = Hive.box<Blog>('blogs');
  BlogRepository({required this.apiClient});

  Future<List<Blog>> fetchBlogs() async {
    try {
      final blogs = await apiClient.fetchBlogs();
      for (var blog in blogs) {
        await blogBox.put(blog.id, blog);
      }
      return blogs;
    } catch (e) {
      return blogBox.values.toList();
    }
  }
}
