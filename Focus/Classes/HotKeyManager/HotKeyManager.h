#import <Foundation/Foundation.h>
#import "DDHotKeyCenter.h"

typedef void(^hotKeyTriggered)(NSInteger screenIndex);

@interface HotKeyManager : NSObject
-(instancetype)initWithHandler:(hotKeyTriggered)action;
-(void)clearHotKeys;
-(void)addHotKey:(DDHotKey *)hotKey screenIndex:(NSInteger)screenIndex;
-(DDHotKey *)hotKeyForScreen:(NSInteger)screenIndex;

@property (nonatomic, assign) BOOL enabled;
@end
