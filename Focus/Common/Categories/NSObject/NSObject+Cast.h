#import <Foundation/Foundation.h>

#define as(TYPE) as([TYPE class])

@interface NSObject (Cast)
@property (nonatomic, strong, readonly) id(^as)(Class ofClass);
@end

extern NSObject * valueMap(id value, id object, SEL selector);
