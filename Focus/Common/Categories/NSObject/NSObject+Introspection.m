#import "NSObject+Introspection.h"
#import <objc/runtime.h>
#import "NSArray+Filter.h"

@implementation NSObject (Introspection)
+(BOOL)property:(NSString *)name conformsTo:(Protocol *)protocol {
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int index = 0; index < propertyCount; index++) {
        objc_property_t property = properties[index];
        const char *propertyName = property_getName(property);
        
        if ([@(propertyName) isEqualToString:name]) {
            const char *attrs = property_getAttributes(property);
            NSString *propertyAttributes = @(attrs);
            NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
            
            return ([attributeItems filter:^BOOL(NSString *item) {
                return [item containsString:[NSString stringWithFormat:@"<%@>", NSStringFromProtocol(protocol)]];
            }].count > 0);
        }
    }
    
    return NO;
}
+(NSArray *)propertiesConformingTo:(Protocol *)protocol {
    NSMutableArray *results = [NSMutableArray new];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int index = 0; index < propertyCount; index++) {
        objc_property_t property = properties[index];
        
        const char *attrs = property_getAttributes(property);
        NSString *propertyAttributes = @(attrs);
        NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
        
        BOOL conforms = ([attributeItems filter:^BOOL(NSString *item) {
            return [item containsString:[NSString stringWithFormat:@"<%@>", NSStringFromProtocol(protocol)]];
        }].count > 0);
        
        if (conforms) {
            const char *propertyName = property_getName(property);
            [results addObject:@(propertyName)];
        }
    }
    
    return results;
}
@end
