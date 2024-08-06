import 'package:blog_explorer/models/blog_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogListItem extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;

  const BlogListItem({Key? key, required this.blog, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Hero(
            tag: blog.id,
            child: CachedNetworkImage(
              imageUrl: blog.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 180,
              imageBuilder: (context, imageProvider) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          ListTile(
            title: Text(blog.title, style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
