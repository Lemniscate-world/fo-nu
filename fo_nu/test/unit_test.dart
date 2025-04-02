import 'package:flutter_test/flutter_test.dart';
import 'package:fo_nu/main.dart';

void main() {
  group('Translation Tests', () {
    test('translateToEwe returns correct translations', () {
      expect(translateToEwe("Hello"), equals("Shalom"));
      expect(translateToEwe("Good"), equals("Eƒe"));
      expect(translateToEwe("Thank you"), equals("Akpe"));
    });

    test('translateToEwe returns default for unknown words', () {
      expect(translateToEwe("Computer"), equals("Nye dzi"));
      expect(translateToEwe("Flutter"), equals("Nye dzi"));
    });
  });
}
