import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/utils/api_client.dart';

class BlogRepository {
  final ApiClient apiClient;

  BlogRepository({required this.apiClient});

  Future<List<Blog>> fetchBlogs() async {
    return apiClient.fetchBlogs();
  }
}
