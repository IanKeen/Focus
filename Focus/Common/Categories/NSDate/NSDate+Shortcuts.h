#import <Foundation/Foundation.h>

@interface NSDate (Shortcuts)
-(NSDate *)startOfDay;
-(NSDate *)startOfDay:(NSTimeZone *)timeZone;
-(NSDate *)endOfDay;
-(NSDate *)endOfDay:(NSTimeZone *)timeZone;

-(NSDate *)startOfWeek;
-(NSDate *)startOfWeek:(NSTimeZone *)timeZone;
-(NSDate *)endOfWeek;
-(NSDate *)endOfWeek:(NSTimeZone *)timeZone;

-(NSDate *)startOfMonth;
-(NSDate *)startOfMonth:(NSTimeZone *)timeZone;
-(NSDate *)endOfMonth;
-(NSDate *)endOfMonth:(NSTimeZone *)timeZone;

-(BOOL)sameDay:(NSDate *)date;
-(BOOL)sameMonth:(NSDate *)date;
-(BOOL)sameYear:(NSDate *)date;

-(NSDate *)dateByAddingDays:(NSInteger)days;
-(NSDate *)dateByAddingWeeks:(NSInteger)weeks;
-(NSDate *)dateByAddingMonths:(NSInteger)months;
-(NSDate *)dateByAddingYears:(NSInteger)years;

-(NSDate *)dateByTakingTimeFrom:(NSDate *)date;
-(NSDate *)resetDateUnit:(NSCalendarUnit)unit;
@end
