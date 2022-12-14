#import "EformpluginPlugin.h"
#if __has_include(<eformplugin/eformplugin-Swift.h>)
#import <eformplugin/eformplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "eformplugin-Swift.h"
#endif

@implementation EformpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEformpluginPlugin registerWithRegistrar:registrar];
}
@end
