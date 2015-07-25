#import <Cocoa/Cocoa.h>

@interface NSScreen (Search)
+(NSScreen *)screenById:(NSNumber *)screenId;
-(NSNumber *)screenId;
@end
