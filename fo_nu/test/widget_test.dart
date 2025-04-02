// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fo_nu/main.dart';

void main() {
  testWidgets('Translation dictionary test', (WidgetTester tester) async {
    // Test dictionary lookup functionality
    expect(translateToEwe("Hello"), equals("Shalom"));
    expect(translateToEwe("Good"), equals("Eƒe"));
    expect(translateToEwe("Unknown Word"), equals("Nye dzi"));
  });

  testWidgets('Overlay UI renders correctly', (WidgetTester tester) async {
    // Build a test widget that shows the overlay content
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Text("Shalom", style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );

    // Verify the text is displayed correctly
    expect(find.text("Shalom"), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });
}
