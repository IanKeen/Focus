#import "HotKeyManager.h"
#import "StoredScreenHotKey.h"

static NSString * kStoredHotKeys = @"HotKeyArray";

@interface HotKeyManager ()
@property (nonatomic, copy) hotKeyTriggered action;
@end

@implementation HotKeyManager
#pragma mark - Lifecycle
-(instancetype)initWithHandler:(hotKeyTriggered)action {
    if (!(self = [super init])) { return nil; }
    self.action = action;
    
    [self registerHotKeys];
    self.enabled = YES;
    return self;
}

#pragma mark - Public
-(void)clearHotKeys {
    [[DDHotKeyCenter sharedHotKeyCenter] unregisterAllHotKeys];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStoredHotKeys];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)addHotKey:(DDHotKey *)hotKey screenIndex:(NSInteger)screenIndex {
    StoredScreenHotKey *storedKey = [[StoredScreenHotKey alloc] initWithHotKey:hotKey screenIndex:screenIndex];
    
    NSArray *stored = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:kStoredHotKeys]];
    NSArray *updated = [stored arrayByAddingObject:[NSKeyedArchiver archivedDataWithRootObject:storedKey]];
    [[NSUserDefaults standardUserDefaults] setObject:updated forKey:kStoredHotKeys];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self registerHotKey:storedKey];
}
-(DDHotKey *)hotKeyForScreen:(NSInteger)screenIndex {
    return [[[self storedHotKeys] filter:^BOOL(StoredScreenHotKey *storedKey) {
        return (storedKey.screenIndex == screenIndex);
        
    }] map:^DDHotKey *(StoredScreenHotKey *storedKey) {
        return [[[DDHotKeyCenter sharedHotKeyCenter] registeredHotKeys].allObjects filter:^BOOL(DDHotKey *item) {
            return (item.keyCode == storedKey.keyCode && item.modifierFlags == storedKey.modifierFlags);
            
        }].firstObject;
    }].firstObject;
}

#pragma mark - Private
-(NSArray *)storedHotKeys {
    NSArray *stored = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:kStoredHotKeys]];
    return [stored map:^StoredScreenHotKey *(id item) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:item];
    }];
}
-(void)registerHotKeys {
    [[self storedHotKeys] enumerate:^(NSInteger index, StoredScreenHotKey *storedKey) {
        [self registerHotKey:storedKey];
    }];
}
-(void)registerHotKey:(StoredScreenHotKey *)storedKey {
    DDHotKey *hotKey = [self hotKeyFrom:storedKey];
    [[DDHotKeyCenter sharedHotKeyCenter] registerHotKey:hotKey];
}
-(DDHotKey *)hotKeyFrom:(StoredScreenHotKey *)storedKey {
    __weak typeof(self) weakSelf = self;
    return [storedKey toHotKey:^(NSEvent *event) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf hotKeyTriggered:storedKey];
    }];
}
-(void)hotKeyTriggered:(StoredScreenHotKey *)storedKey {
    if (!self.enabled) { return; }
    
    if (self.action) { self.action(storedKey.screenIndex); }
}
@end
