#import <Foundation/Foundation.h>

@class DDHotKeyTextField;

@interface HotKeyControllMapping : NSObject
@property (nonatomic) NSInteger index;
@property (nonatomic, weak) DDHotKeyTextField *textField;
@property (nonatomic, weak) NSButton *clearButton;
@end
