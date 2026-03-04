import 'package:app/model/categories.dart';
import 'package:app/model/news.dart';
import 'package:app/services/newsService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NewsProviders with ChangeNotifier {
  List<Categories> _categories = [];
  List<News> _news = [];
  String? _selectedCategory;
  bool _isLoading = false;

  List<Categories> get categories => _categories;
  List<News> get news => _news;
  String? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    try {
      _categories = await NewsService().fetchcategories();
      debugPrint(
        'Fetched categories: ${_categories.map((c) => c.name).toList()}',
      );
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      // ensure UI is updated when categories arrive (or error occurs)
      notifyListeners();
    }
  }

  Future<void> fetchNews({String? category}) async {
    _isLoading = true;
    _selectedCategory = category;
    notifyListeners();
    try {
      _news = await NewsService().fetchNews(category: category);
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
