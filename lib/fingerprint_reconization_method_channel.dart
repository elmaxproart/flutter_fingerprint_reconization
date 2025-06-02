import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fingerprint_reconization_platform_interface.dart';

/// An implementation of [FingerprintReconizationPlatform] that uses method channels.
class MethodChannelFingerprintReconization extends FingerprintReconizationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fingerprint_reconization');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
