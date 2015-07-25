#import "StatusBarIconHandler.h"

@interface StatusBarIconHandler ()
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) statusBarIconAction action;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@property (nonatomic, strong) NSStatusItem *statusBarItem;
@end

@implementation StatusBarIconHandler
#pragma mark - Lifecycle
-(instancetype)initWithTitle:(NSString *)title action:(statusBarIconAction)action {
    if (!(self = [super init])) { return nil; }
    self.title = title;
    self.action = action;
    self.target = nil;
    self.selector = nil;
    self.statusBarItem = [self createStatusBarItem];
    return self;
}
-(instancetype)initWithTitle:(NSString *)title target:(id)target selector:(SEL)selector {
    if (!(self = [super init])) { return nil; }
    self.title = title;
    self.action = nil;
    self.target = target;
    self.selector = selector;
    self.statusBarItem = [self createStatusBarItem];
    return self;
}
-(void)dealloc {
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusBarItem];
    self.statusBarItem = nil;
}

#pragma mark - Private
-(NSStatusItem *)createStatusBarItem {
    NSStatusItem *item = [[NSStatusBar systemStatusBar] statusItemWithLength:24.0];
    item.title = self.title;
    item.button.target = self;
    item.button.action = @selector(statusBarItemSelected);
    return item;
}

#pragma mark - Action
-(void)statusBarItemSelected {
    if (self.action) {
        self.action();
    } else if (self.target && self.selector) {
        [self.target performSelectorOnMainThread:self.selector withObject:nil waitUntilDone:NO];
    }
}
@end
