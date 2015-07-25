#import <Foundation/Foundation.h>

typedef id (^mapValueFunction)(id value);

@interface NSObject (Map)
@property (nonatomic, strong, readonly) NSObject * (^map)(mapValueFunction function);
@property (nonatomic, strong, readonly) NSObject * (^mapSelector)(id object, SEL selector);
@end
