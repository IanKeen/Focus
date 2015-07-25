#import <Foundation/Foundation.h>

@interface NSObject (Introspection)
+(BOOL)property:(NSString *)name conformsTo:(Protocol *)protocol;
+(NSArray *)propertiesConformingTo:(Protocol *)protocol;
@end
