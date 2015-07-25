#import "StoredScreenHotKey.h"

@implementation StoredScreenHotKey
#pragma mark - NSCoder
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.keyCode) forKey:@"keyCode"];
    [aCoder encodeObject:@(self.modifierFlags) forKey:@"modifierFlags"];
    [aCoder encodeObject:@(self.screenIndex) forKey:@"screenIndex"];
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super init])) { return nil; }
    
    self.keyCode = [[aDecoder decodeObjectForKey:@"keyCode"] unsignedShortValue];
    self.modifierFlags = [[aDecoder decodeObjectForKey:@"modifierFlags"] unsignedIntegerValue];
    self.screenIndex = [[aDecoder decodeObjectForKey:@"screenIndex"] integerValue];
    
    return self;
}

#pragma mark - fromHotKey
-(instancetype)initWithHotKey:(DDHotKey *)hotKey screenIndex:(NSInteger)index {
    if (!(self = [super init])) { return nil; }
    self.keyCode = hotKey.keyCode;
    self.modifierFlags = hotKey.modifierFlags;
    self.screenIndex = index;
    return self;
}

#pragma mark - toHotKey
-(DDHotKey *)toHotKey:(void (^)(NSEvent *))task {
    return [DDHotKey hotKeyWithKeyCode:self.keyCode modifierFlags:self.modifierFlags task:task];
}
@end