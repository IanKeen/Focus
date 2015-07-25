#import <Foundation/Foundation.h>

typedef id (^mapFunction)(id item);
typedef id (^mapWithIndexFunction)(id item, NSInteger index);

@interface NSArray (Map)
-(NSArray *)map:(mapFunction)function;
-(NSArray *)mapWithIndex:(mapWithIndexFunction)function;
-(NSArray *)flatMap:(mapFunction)function;
-(NSArray *)flatten;
@end