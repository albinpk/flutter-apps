import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/utils/test_helper.dart';

void main() {
  group('TestHelper', () {
    test('isWeb getter should be equal to kIsWeb', () {
      expect(const TestHelper().isWeb, kIsWeb);
    });
  });
}
