#import "AppDelegate.h"

#import "StatusBarIconHandler.h"
#import "HotKeyManager.h"

#import "VCAbout.h"
#import "VCPreferences.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSWindow *aboutWindow;
@property (nonatomic, strong) StatusBarIconHandler *statusBarIconHandler;
@property (nonatomic, strong) HotKeyManager *hotKeyManager;
@end

@implementation AppDelegate
#pragma mark - Lifecycle
-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusBarIconHandler = [[StatusBarIconHandler alloc] initWithTitle:@"F" target:self selector:@selector(preferencesPress:)];
    self.hotKeyManager = [[HotKeyManager alloc] initWithHandler:^(NSInteger screenIndex) {
        NSArray *screens = [NSScreen screens];
        if (screenIndex > -1 && screenIndex < screens.count) {
            NSScreen *screen = [NSScreen screens][screenIndex];
            [self centerMouseInScreen:screen];
        }
    }];
}
-(void)applicationWillTerminate:(NSNotification *)aNotification {
    self.statusBarIconHandler = nil;
}

#pragma mark - About
-(void)installAboutWindow {
    if (self.aboutWindow) { return; }
    
    VCAbout *instance = [[VCAbout alloc] initWithNibName:NSStringFromClass([VCAbout class]) bundle:nil];
    self.aboutWindow = [NSWindow windowWithContentViewController:instance];
    [self.window addChildWindow:self.aboutWindow ordered:NSWindowAbove];
}
-(IBAction)aboutPress:(id)sender {
    [self installAboutWindow];
    [self.aboutWindow makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:YES];
}

#pragma mark - Preferences
-(void)installPreferences {
    if (self.window.contentViewController != nil) { return; }
    
    VCPreferences *instance = [[VCPreferences alloc] initWithHotKeyManager:self.hotKeyManager];
    self.window.contentViewController = instance;
}
-(IBAction)preferencesPress:(id)sender {
    [self installPreferences];
    [self.window makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:YES];
}

#pragma mark - Private
-(void)centerMouseInScreen:(NSScreen *)screen {
    NSPoint center = NSMakePoint(NSMidX(screen.frame), NSMidY(screen.frame));
    CGEventSourceRef evsrc = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    CGEventSourceSetLocalEventsSuppressionInterval(evsrc, 0.0);
    CGAssociateMouseAndMouseCursorPosition (0);
    CGWarpMouseCursorPosition(center);
    CGAssociateMouseAndMouseCursorPosition (1);
}
@end
