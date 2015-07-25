#import "NSScreen+Search.h"

@implementation NSScreen (Search)
+(NSScreen *)screenById:(NSNumber *)screenId {
    return [[NSScreen screens] filter:^BOOL(NSScreen *screen) {
        NSNumber *thisScreenID = [screen.deviceDescription objectForKey:@"NSScreenNumber"];
        return [screenId isEqualToNumber:thisScreenID];
    }].firstObject;
}
-(NSNumber *)screenId {
    NSNumber *thisScreenID = [self.deviceDescription objectForKey:@"NSScreenNumber"];
    return thisScreenID;
}
@end
