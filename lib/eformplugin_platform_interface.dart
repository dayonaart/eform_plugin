import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'eformplugin_method_channel.dart';

abstract class EformpluginPlatform extends PlatformInterface {
  /// Constructs a EformpluginPlatform.
  EformpluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static EformpluginPlatform _instance = MethodChannelEformplugin();

  /// The default instance of [EformpluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelEformplugin].
  static EformpluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EformpluginPlatform] when
  /// they register themselves.
  static set instance(EformpluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> openDoa({String? route}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
