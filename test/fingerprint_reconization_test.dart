import 'package:flutter_test/flutter_test.dart';
import 'package:fingerprint_reconization/fingerprint_reconization.dart';
import 'package:fingerprint_reconization/fingerprint_reconization_platform_interface.dart';
import 'package:fingerprint_reconization/fingerprint_reconization_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFingerprintReconizationPlatform
    with MockPlatformInterfaceMixin
    implements FingerprintReconizationPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> authenticate() {
    // TODO: implement authenticate
    throw UnimplementedError();
  }
}

void main() {
  final FingerprintReconizationPlatform initialPlatform =
      FingerprintReconizationPlatform.instance;

  test('$MethodChannelFingerprintReconization is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelFingerprintReconization>(),
    );
  });

  test('getPlatformVersion', () async {
    FingerprintReconization fingerprintReconizationPlugin =
        FingerprintReconization();
    MockFingerprintReconizationPlatform fakePlatform =
        MockFingerprintReconizationPlatform();
    FingerprintReconizationPlatform.instance = fakePlatform;

    expect(await fingerprintReconizationPlugin.getPlatformVersion(), '42');
  });
}
