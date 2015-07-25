#import <Foundation/Foundation.h>
#import "DDHotKeyCenter.h"

@interface StoredScreenHotKey : NSObject <NSCoding>
@property (nonatomic) unsigned short keyCode;
@property (nonatomic) NSUInteger modifierFlags;
@property (nonatomic) NSInteger screenIndex;

-(instancetype)initWithHotKey:(DDHotKey *)hotKey screenIndex:(NSInteger)index;
-(DDHotKey *)toHotKey:(void (^)(NSEvent *))task;
@end