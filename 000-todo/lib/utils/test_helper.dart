import 'package:flutter/foundation.dart';

/// Just a wrapper for [kIsWeb], for testing purpose
class TestHelper {
  const TestHelper();

  /// Returns [kIsWeb]
  bool get isWeb => kIsWeb;
}
