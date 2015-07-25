#import "NSArray+Filter.h"
#import "NSArray+Reduce.h"

@implementation NSArray (Filter)
-(NSArray *)filter:(filterFunction)function {
    return [self reduce:@[] function:^id(NSArray *accumulator, id item) {
        if (function(item)) {
            return [accumulator arrayByAddingObject:item];
        }
        return accumulator;
    }];
}
@end