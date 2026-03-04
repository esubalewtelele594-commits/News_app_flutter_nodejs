// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/services/newsService.dart';
// import 'package:app/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  test('smoke test getcategories', () async {
    final categories = await NewsService().fetchcategories();
    expect(categories, isNotNull);
    print(categories[1].name);
  });
  test('smoke test getNews', () async {
    final news = await NewsService().fetchNews(category: "All");

    debugPrint('fetchNews returned ${news.length} items');

    expect(news, isNotNull);
    expect(
      news.length,
      greaterThan(0),
      reason: 'should get at least one news item',
    );
    // print the first title for manual inspection
    debugPrint('first title: ${news.first.title}');
    debugPrint('Second title: ${news[1].title}');
  });
}
