#import "NSDate+Building.h"

@implementation NSDate (Building)
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day inTimezone:(NSTimeZone *)timeZone {
    NSDateComponents * components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.timeZone = timeZone;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self dateWithYear:year month:month day:day inTimezone:[NSTimeZone defaultTimeZone]];
}
@end
