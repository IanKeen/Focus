#import "VCPreferences.h"
#import "HotKeyManager.h"
#import "DDHotKeyTextField.h"
#import "HotKeyControllMapping.h"

static CGFloat kUIElementHeight = 25.0;
static CGFloat kUIElementBuffer = 4.0;

@interface VCPreferences ()
@property (nonatomic, weak) IBOutlet NSView *textFieldContainer;
@property (nonatomic, weak) HotKeyManager *hotKeyManager;

@property (nonatomic, strong) NSMutableArray *controlMapping;
@end

@implementation VCPreferences
#pragma mark - Lifecycle
-(instancetype)initWithHotKeyManager:(HotKeyManager *)hotKeyManager {
    if (!(self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil])) { return nil; }
    self.hotKeyManager = hotKeyManager;
    self.controlMapping = [NSMutableArray new];
    return self;
}
-(void)viewWillAppear {
    [super viewWillAppear];
    self.hotKeyManager.enabled = NO;
    
    [self resetUI];
    [self buildUI];
}
-(void)viewWillDisappear {
    [super viewWillDisappear];
    self.hotKeyManager.enabled = YES;
}

#pragma mark - Actions
-(IBAction)savePress:(id)sender {
    [self.hotKeyManager clearHotKeys];
    
    [self.controlMapping enumerate:^(NSInteger index, HotKeyControllMapping *mapping) {
        if (mapping.textField.hotKey) {
            [self.hotKeyManager addHotKey:mapping.textField.hotKey screenIndex:mapping.index];
        }
    }];
    
    [[NSApp mainWindow] orderOut:nil];
}
-(IBAction)dismissController:(id)sender {
    [[NSApp mainWindow] orderOut:nil];
}
-(IBAction)exitPress:(id)sender {
    [NSApp terminate:self];
}

#pragma mark - UI Building
-(void)resetUI {
    [self.controlMapping removeAllObjects];
    
    while (self.textFieldContainer.subviews.count > 0) {
        [self.textFieldContainer.subviews[0] removeFromSuperview];
    }
}
-(void)buildUI {
    [[NSScreen screens] enumerate:^(NSInteger index, NSScreen *screen) {
        [self buildScreenUI:index];
    }];
}
-(void)buildScreenUI:(NSInteger)index {
    NSTextField *label = [self screenLabel:index];
    NSButton *button = [self screenButton:index];
    DDHotKeyTextField *textField = [self screenTextField:index label:label button:button];
    
    DDHotKey *hotKey = [self.hotKeyManager hotKeyForScreen:index];
    textField.hotKey = hotKey;
    
    HotKeyControllMapping *mapping = [HotKeyControllMapping new];
    mapping.clearButton = button;
    mapping.textField = textField;
    mapping.index = index;
    [self.controlMapping addObject:mapping];
    
    [self.textFieldContainer addSubview:label];
    [self.textFieldContainer addSubview:textField];
    [self.textFieldContainer addSubview:button];
}

#pragma mark - UI Helpers
-(CGFloat)top {
    return (NSHeight(self.textFieldContainer.bounds) - kUIElementHeight - kUIElementBuffer);
}
-(NSTextField *)screenLabel:(NSInteger)index {
    NSRect labelFrame = NSMakeRect(
               kUIElementBuffer,
               [self top] - (kUIElementHeight * index), // + kUIElementBuffer,
               70.0,
               kUIElementHeight
               );
    NSTextField *label = [[NSTextField alloc] initWithFrame:labelFrame];
    label.bordered = NO;
    label.backgroundColor = [NSColor clearColor];
    label.editable = NO;
    label.placeholderString = [NSString stringWithFormat:@"Screen %@", @(index + 1)];
    return label;
}
-(DDHotKeyTextField *)screenTextField:(NSInteger)index label:(NSTextField *)label button:(NSButton *)button {
    DDHotKeyTextField *textField = [[DDHotKeyTextField alloc] init];
    textField.placeholderString = @"Keyboard Shortcut";
    textField.frame = NSMakeRect(
               NSMaxX(label.frame) + kUIElementBuffer,
               [self top] - (kUIElementHeight * index),
               NSWidth(self.textFieldContainer.bounds) - (kUIElementBuffer * 4.0) - NSWidth(label.frame) - NSWidth(button.bounds),
               kUIElementHeight
               );
    return textField;
}
-(NSButton *)screenButton:(NSInteger)index {
    static CGFloat width = 44.0;
    
    NSRect buttonFrame = NSMakeRect(
                NSWidth(self.textFieldContainer.bounds) - width - kUIElementBuffer,
                [self top] - (kUIElementHeight * index) + kUIElementBuffer,
                width,
                kUIElementHeight
                );
    
    NSButton *button = [[NSButton alloc] initWithFrame:buttonFrame];
    button.bezelStyle = NSSmallSquareBezelStyle;
    button.title = @"Clear";
    button.target = self;
    button.action = @selector(clearButtonPressed:);
    
    return button;
}
-(void)clearButtonPressed:(NSButton *)sender {
    [self.controlMapping enumerate:^(NSInteger index, HotKeyControllMapping *mapping) {
        if ([mapping.clearButton isEqual:sender]) {
            mapping.textField.hotKey = nil;
        }
    }];
}
@end
