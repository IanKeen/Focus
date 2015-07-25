#import "NSObject+Null.h"

BOOL isNil(id object) {
    return (object == nil ||
            [object isKindOfClass:[NSNull class]] ||
            ([object isKindOfClass:[NSString class]] && ([object isEqualToString:@""] || [object isEqualToString:@"null"] || [object isEqualToString:@"nil"])));
}
