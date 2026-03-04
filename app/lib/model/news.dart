class News {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String category;
  final DateTime publishedAt;
  final String source;
  News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.category,
    required this.publishedAt,
    required this.source,
  });
  factory News.fromJson(Map<String, dynamic> json) {
    // The backend occasionally returns null for some string fields.
    // Provide sensible defaults so our non-nullable model doesn't crash.
    String parseString(String? value) => value ?? '';

    DateTime parseDate(dynamic value) {
      if (value == null || (value is String && value.isEmpty)) {
        return DateTime.now();
      }
      return DateTime.tryParse(value.toString()) ?? DateTime.now();
    }

    return News(
      title: parseString(json['title']),
      description: parseString(json['description']),
      imageUrl: parseString(json['imageUrl']),
      content: parseString(json['content']),
      category: parseString(json['category']),
      publishedAt: parseDate(json['publishedAt']),
      source: parseString(json['source']),
    );
  }
}
