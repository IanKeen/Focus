#import <Foundation/Foundation.h>

typedef void (^enumerateFunction)(NSInteger index, id item);

@interface NSArray (Enumerate)
-(void)enumerate:(enumerateFunction)function;
@end