
import 'fingerprint_reconization_platform_interface.dart';

class FingerprintReconization {
  Future<String?> getPlatformVersion() {
    return FingerprintReconizationPlatform.instance.getPlatformVersion();
  }
}
