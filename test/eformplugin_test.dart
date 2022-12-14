import 'package:flutter_test/flutter_test.dart';
import 'package:eformplugin/eformplugin.dart';
import 'package:eformplugin/eformplugin_platform_interface.dart';
import 'package:eformplugin/eformplugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEformpluginPlatform
    with MockPlatformInterfaceMixin
    implements EformpluginPlatform {
  @override
  Future<String?> openDoa({String? route}) => Future.value('42');
}

void main() {
  final EformpluginPlatform initialPlatform = EformpluginPlatform.instance;

  test('$MethodChannelEformplugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEformplugin>());
  });

  test('openDoa', () async {
    Eformplugin eformpluginPlugin = Eformplugin();
    MockEformpluginPlatform fakePlatform = MockEformpluginPlatform();
    EformpluginPlatform.instance = fakePlatform;

    expect(await eformpluginPlugin.openDoa(), '42');
  });
}
