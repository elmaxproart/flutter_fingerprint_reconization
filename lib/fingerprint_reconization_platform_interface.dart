import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fingerprint_reconization_method_channel.dart';

abstract class FingerprintReconizationPlatform extends PlatformInterface {
  /// Constructs a FingerprintReconizationPlatform.
  FingerprintReconizationPlatform() : super(token: _token);

  static final Object _token = Object();

  static FingerprintReconizationPlatform _instance = MethodChannelFingerprintReconization();

  /// The default instance of [FingerprintReconizationPlatform] to use.
  ///
  /// Defaults to [MethodChannelFingerprintReconization].
  static FingerprintReconizationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FingerprintReconizationPlatform] when
  /// they register themselves.
  static set instance(FingerprintReconizationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
