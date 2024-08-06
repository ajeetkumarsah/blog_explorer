import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:blog_explorer/models/blog_model.dart';
import 'package:blog_explorer/screens/blog_detail_screen.dart';
import 'package:blog_explorer/widgets/blog_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogInitial) {
            BlocProvider.of<BlogBloc>(context).add(FetchBlogs());
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogsLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                Blog blog = state.blogs[index];
                return BlogListItem(
                    blog: blog,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    });
              },
            );
          } else if (state is BlogError) {
            return Center(
                child:
                    Text(state.message, style: TextStyle(color: Colors.white)));
          } else {
            return Center(
                child: Text('Unknown state',
                    style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
}
