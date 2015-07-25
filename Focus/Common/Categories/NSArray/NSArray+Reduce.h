#import <Foundation/Foundation.h>

typedef id (^reduceFunction)(id accumulator, id item);

@interface NSArray (Reduce)
-(id)reduce:(id)initial function:(reduceFunction)function;
@end