#import <Foundation/Foundation.h>

typedef BOOL (^dictionaryFilterFunction)(id key, id value);

@interface NSDictionary (Filter)
-(NSDictionary *)filter:(dictionaryFilterFunction)function;
@end
