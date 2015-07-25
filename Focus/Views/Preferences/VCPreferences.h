#import <Cocoa/Cocoa.h>
#import "HotKeyManager.h"

@interface VCPreferences : NSViewController
-(instancetype)initWithHotKeyManager:(HotKeyManager *)hotKeyManager;
@end
