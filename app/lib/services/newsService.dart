import 'dart:convert';
import 'package:app/model/categories.dart';
import 'package:app/model/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String baseurl = "http://localhost:3002/api";

  Future<List<Categories>> fetchcategories() async {
    final response = await http.get(Uri.parse('$baseurl/categories'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Categories>.from(
        data['data'].map((json) => Categories.fromJson(json)),
      );
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<List<News>> fetchNews({String? category}) async {
    final Uri uri = Uri.parse(
      '$baseurl/news${category != null ? '?category=${Uri.encodeQueryComponent(category.toLowerCase())}' : ''}',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<News>.from(data['data'].map((json) => News.fromJson(json)));
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
