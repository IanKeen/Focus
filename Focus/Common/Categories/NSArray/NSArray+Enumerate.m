#import "NSArray+Enumerate.h"

@implementation NSArray (Enumerate)
-(void)enumerate:(enumerateFunction)function {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        function(idx, obj);
    }];
}
@end