import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eformplugin/eformplugin_method_channel.dart';

void main() {
  MethodChannelEformplugin platform = MethodChannelEformplugin();
  const MethodChannel channel = MethodChannel('eformplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('openDoa', () async {
    await platform.openDoa();
  });
}
