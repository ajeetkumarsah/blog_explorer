class Blog {
  final String id;
  final String title;
  final String imageUrl;
  final String content;
  final bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    this.isFavorite = false,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] != null ? json['id'].toString() : '0',
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      content: json['content'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
