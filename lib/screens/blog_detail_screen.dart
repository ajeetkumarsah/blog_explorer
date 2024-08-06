import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon:
                Icon(blog.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              BlocProvider.of<BlogBloc>(context).add(MarkFavorite(blog.id));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
                tag: blog.id,
                child: CachedNetworkImage(imageUrl: blog.imageUrl)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(blog.title, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
