#import "NSScreen+BuiltIn.h"

@implementation NSScreen (BuiltIn)
-(BOOL)isBuiltIn {
    NSNumber *screenID = [self.deviceDescription objectForKey:@"NSScreenNumber"];
    CGDirectDisplayID aID = [screenID unsignedIntValue];
    return CGDisplayIsBuiltin(aID);
}
@end
