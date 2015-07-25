#import "NSArray+Map.h"

@implementation NSArray (Map)
-(NSArray *)map:(mapFunction)function {
    return [self mapWithIndex:^id(id item, NSInteger index) {
        return function(item);
    }];
}
-(NSArray *)mapWithIndex:(mapWithIndexFunction)function {
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = function(obj, idx);
        if (value != nil) {
            [result addObject:value];
        }
    }];
    return result;
}
-(NSArray *)flatMap:(mapFunction)function {
    return [[self flatten] map:function];
}
-(NSArray *)flatten {
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [result addObjectsFromArray:obj];
        }
    }];
    return result;
}
@end