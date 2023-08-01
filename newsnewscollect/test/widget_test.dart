import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:newsnewscollect/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(apiUrl: 'https://api.collectapi.com/news/getNews?country=tr&tag=general', apiKey: '64uwmp9Gd42pXYiQJCxxun:2znBzmkUH17dnUs1kKQr2b',));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
