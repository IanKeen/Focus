#import "NSDate+TimeSince.h"

@implementation NSDate (TimeSince)
-(NSString *)timeSince {
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:self];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self toDate:[NSDate date] options:0];
    
    NSMutableString *when = [NSMutableString string];
    if (seconds > 10) {
        while (YES) {
            if (comp.year > 0) {
                [when appendFormat:@"%iyr%@ ", (int)comp.year, (comp.year > 1 ? @"s" : @"")];
            }
            if (comp.month > 0) {
                BOOL first = ([when length] == 0);
                [when appendFormat:@"%imnth%@ ", (int)comp.month, (comp.month > 1 ? @"s" : @"")];
                if (!first) { break; }
            }
            if (comp.weekOfYear > 0) {
                BOOL first = ([when length] == 0);
                [when appendFormat:@"%iwk%@ ", (int)comp.weekOfYear, (comp.weekOfYear > 1 ? @"s" : @"")];
                if (!first) { break; }
            }
            if (comp.day > 0) {
                BOOL first = ([when length] == 0);
                [when appendFormat:@"%iday%@ ", (int)comp.day, (comp.day > 1 ? @"s" : @"")];
                if (!first) { break; }
            }
            if (comp.hour > 0) {
                BOOL first = ([when length] == 0);
                [when appendFormat:@"%ihr%@ ", (int)comp.hour, (comp.hour > 1 ? @"s" : @"")];
                if (!first) { break; }
            }
            if (comp.minute > 0) {
                BOOL first = ([when length] == 0);
                [when appendFormat:@"%imin%@ ", (int)comp.minute, (comp.minute > 1 ? @"s" : @"")];
                if (!first) { break; }
            }
            if (comp.second > 0) {
                BOOL first = ([when length] == 0);
                [when appendFormat:@"%isec%@ ", (int)comp.second, (comp.second > 1 ? @"s" : @"")];
                if (!first) { break; }
            }
            
            break;
        }
        [when appendString:@"ago"];
        
    } else {
        //date is recent!
        [when appendString:@"Just now"];
    }
    return when;
}
@end
