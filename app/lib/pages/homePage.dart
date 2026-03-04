import 'package:app/model/news.dart';
import 'package:app/providers/news_providers.dart';
import 'package:flutter/material.dart';
import 'package:app/constant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProviders>(context, listen: false);
      newsProvider.fetchCategories();
      newsProvider.fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search news...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search, color: textcolor),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Consumer<NewsProviders>(
        builder: (context, newsProvider, child) {
          // show loading indicator while news is loading or categories are not yet available
          if (newsProvider.isLoading || newsProvider.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // safe to access list items now
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryList(newsProvider),
                  SizedBox(height: 16),
                  newsProvider.news.isNotEmpty
                      ? _buildNewsList(newsProvider.news.first)
                      : Text('No news available for this category.'),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Around the world',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textcolor,
                        ),
                      ),
                      TextButton(onPressed: () {}, child: Text('see more')),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildhorizontalNewsList(newsProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildCategoryList(NewsProviders newsProvider) {
  return SizedBox(
    height: 60,
    child: newsProvider.categories.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsProvider.categories.length,
            itemBuilder: (context, index) {
              final category = newsProvider.categories[index];
              final isSelcted = category.name == newsProvider.selectedCategory;

              return Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => newsProvider.fetchNews(
                    category: category.name == 'All' ? null : category.name,
                  ),
                  child: Chip(
                    backgroundColor: isSelcted
                        ? Colors.purple
                        : Colors.grey[300],
                    label: Text(
                      category.name,
                      style: TextStyle(
                        color: isSelcted ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
  );
}

Widget _buildNewsList(News news) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple[50],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textcolor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          news.description,
          style: TextStyle(fontSize: 14, color: textcolor),
        ),
      ],
    ),
  );
}

Widget _buildhorizontalNewsList(NewsProviders newsProvider) {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newsProvider.news.length,
      itemBuilder: (context, index) {
        final news = newsProvider.news[index];
        return _buildAroundTheWorldCard(news, context);
      },
    ),
  );
}

Widget _buildAroundTheWorldCard(News news, BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(news.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              news.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              news.category,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    ),
  );
}
