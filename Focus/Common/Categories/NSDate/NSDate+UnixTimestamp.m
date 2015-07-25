#import "NSDate+UnixTimestamp.h"

@implementation NSDate (UnixTimestamp)
-(NSString *)unixTimestampString {
    return [NSString stringWithFormat:@"%ld", (long)[self timeIntervalSince1970]];
}
-(NSNumber *)unixTimestamp {
    NSString *string = [self unixTimestampString];
    
    static NSNumberFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
    });
    NSNumber *number = [formatter numberFromString:string];
    return number;
}
@end
