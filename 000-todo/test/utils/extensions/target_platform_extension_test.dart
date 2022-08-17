import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/utils/extensions/target_platform_extension.dart';

void main() {
  group('TargetPlatformExtension', () {
    test(
      'isDesktop should return true on linux, macos and windows. '
      'and should return false on others',
      () {
        expect(TargetPlatform.linux.isDesktop, isTrue);
        expect(TargetPlatform.macOS.isDesktop, isTrue);
        expect(TargetPlatform.windows.isDesktop, isTrue);

        expect(TargetPlatform.android.isDesktop, isFalse);
        expect(TargetPlatform.iOS.isDesktop, isFalse);
        expect(TargetPlatform.fuchsia.isDesktop, isFalse);
      },
    );

    test(
      'isMobile should return true on android, ios and fuchsia. '
      'and should return false on others',
      () {
        expect(TargetPlatform.android.isMobile, isTrue);
        expect(TargetPlatform.iOS.isMobile, isTrue);
        expect(TargetPlatform.fuchsia.isMobile, isTrue);

        expect(TargetPlatform.linux.isMobile, isFalse);
        expect(TargetPlatform.macOS.isMobile, isFalse);
        expect(TargetPlatform.windows.isMobile, isFalse);
      },
    );
  });
}
