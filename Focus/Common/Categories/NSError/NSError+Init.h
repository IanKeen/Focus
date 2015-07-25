#import <Foundation/Foundation.h>

@interface NSError (Shortcut)
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description;
@end

extern NSError * error(NSString *domain, NSString *description);