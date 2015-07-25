#import <Foundation/Foundation.h>

@interface NSDate (Building)
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day inTimezone:(NSTimeZone *)timeZone;
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end
