import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fo_nu/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    testWidgets('Test dictionary and translation functionality',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test the translation function
      expect(app.translateToEwe("Hello"), equals("Shalom"));
      expect(app.translateToEwe("Good"), equals("Eƒe"));
      expect(app.translateToEwe("Unknown Word"), equals("Nye dzi"));
    });
  });
}