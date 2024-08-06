import 'package:blog_explorer/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String baseUrl = 'https://intent-kit-16.hasura.app/';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    final response =
        await http.get(Uri.parse('${baseUrl}api/rest/blogs'), headers: {
      'x-hasura-admin-secret': adminSecret,
    });
    // var logger = Logger();

    // logger.d("Logger :${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)["blogs"];

      debugPrint('===>Body:${data.length}');
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<Blog> fetchBlogDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/blogs/$id'));

    if (response.statusCode == 200) {
      return Blog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load blog detail');
    }
  }
}
