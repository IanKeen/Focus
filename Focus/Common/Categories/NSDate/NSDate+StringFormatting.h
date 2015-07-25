#import <Foundation/Foundation.h>

@interface NSDate (StringFormatting)
-(NSString *)toStringWithTimeStyle:(NSDateFormatterStyle)style;
-(NSString *)toStringWithTimeStyle:(NSDateFormatterStyle)style timezone:(NSTimeZone *)timezone;

-(NSString *)toStringWithDateStyle:(NSDateFormatterStyle)style;
-(NSString *)toStringWithDateStyle:(NSDateFormatterStyle)style timezone:(NSTimeZone *)timezone;

-(NSString *)toStringWithFormat:(NSString *)format;
-(NSString *)toStringWithFormat:(NSString *)format timezone:(NSTimeZone *)timezone;
@end
