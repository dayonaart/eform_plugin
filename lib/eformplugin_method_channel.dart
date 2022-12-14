import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'eformplugin_platform_interface.dart';

/// An implementation of [EformpluginPlatform] that uses method channels.
class MethodChannelEformplugin extends EformpluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('eformplugin');

  @override
  Future<String?> openDoa({String? route}) async {
    final version = await methodChannel.invokeMethod<String>('openDoa', route);
    return version;
  }
}
