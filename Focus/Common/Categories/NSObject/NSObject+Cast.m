#import "NSObject+Cast.h"

@implementation NSObject (Cast)
-(id (^)(__unsafe_unretained Class))as {
    __weak typeof(self) weakSelf = self;
    return ^(Class ofClass) {
        return [weakSelf isKindOfClass:ofClass] ? weakSelf : nil;
    };
}
@end