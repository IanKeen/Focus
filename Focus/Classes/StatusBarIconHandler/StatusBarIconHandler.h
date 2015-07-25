#import <Foundation/Foundation.h>

typedef void(^statusBarIconAction)();

@interface StatusBarIconHandler : NSObject
-(instancetype)initWithTitle:(NSString *)title action:(statusBarIconAction)action;
-(instancetype)initWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
@end
