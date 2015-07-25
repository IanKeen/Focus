#import "NSError+Init.h"

@implementation NSError (Shortcut)
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description {
    NSError *instance = [NSError errorWithDomain:domain code:0 userInfo:@{NSLocalizedDescriptionKey: description}];
    return instance;
}
@end

NSError * error(NSString *domain, NSString *description) { return [NSError errorWithDomain:domain description:description]; }