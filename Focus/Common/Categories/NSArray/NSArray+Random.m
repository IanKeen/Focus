#import "NSArray+Random.h"

@implementation NSArray (Random)
-(id)randomElement {
    if (self.count == 0) { return nil; }
    
    u_int32_t random = arc4random_uniform((u_int32_t)self.count);
    return self[random];
}
@end
