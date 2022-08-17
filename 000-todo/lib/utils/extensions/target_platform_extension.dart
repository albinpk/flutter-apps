import 'package:flutter/foundation.dart';

extension TargetPlatformExtension on TargetPlatform {
  bool get isDesktop => const <TargetPlatform>{
        TargetPlatform.linux,
        TargetPlatform.macOS,
        TargetPlatform.windows,
      }.contains(this);

  bool get isMobile => const <TargetPlatform>{
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.fuchsia,
      }.contains(this);
}
