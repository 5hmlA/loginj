#import "LoginjPlugin.h"
#if __has_include(<loginj/loginj-Swift.h>)
#import <loginj/loginj-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "loginj-Swift.h"
#endif

@implementation LoginjPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLoginjPlugin registerWithRegistrar:registrar];
}
@end
