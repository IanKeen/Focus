#import <Foundation/Foundation.h>

typedef BOOL (^filterFunction)(id item);

@interface NSArray (Filter)
-(NSArray *)filter:(filterFunction)function;
@end