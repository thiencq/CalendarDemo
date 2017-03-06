//
//  Helper.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/3/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "Helper.h"

@interface Helper()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation Helper

+ (instancetype)instance {
    Helper *helper = [Helper new];
    return helper;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_dateFormatter setCalendar:gregorianCalendar];
        
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [_dateFormatter setLocale:usLocale];
    }
    
    return _dateFormatter;
}

- (NSString *)getCurrentDate
{
    [self.dateFormatter setDateFormat:@"dd"];
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getCurrentMonth
{
    [self.dateFormatter setDateFormat:@"MM"];
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getCurrentYear
{
    [self.dateFormatter setDateFormat:@"yyyy"];
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getCurrentDay
{
    [self.dateFormatter setDateFormat:@"EEEE"];
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)getMonthString:(NSInteger)index
{
    NSArray *months = @[@"January", @"Febuary", @"March", @"April", @"May", @"June",
                        @"July", @"August", @"September", @"October", @"November", @"December"];
    
    return months[index-1];
}

- (NSArray *)daysInWeeks {
    return @[@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
}

- (NSString *)getDayString:(NSInteger)index
{
    NSArray *daysInWeeks = [self daysInWeeks];
    return daysInWeeks[index];
}


- (NSInteger)getDaysInMonth:(NSInteger)month year:(NSInteger)year
{
    NSInteger daysInFeb = 28;
    if (year % 4 == 0) {
        daysInFeb = 29;
    }
    
    NSInteger daysInMonth [12] = {31,daysInFeb,31,30,31,30,31,31,30,31,30,31};
    return daysInMonth[month-1];
}

- (NSString *)getDayOfDate:(NSInteger)date month:(NSInteger)month year:(NSInteger)year
{
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *capturedStartDate = [self.dateFormatter dateFromString: [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,date]];
    
    [self.dateFormatter setDateFormat: @"EEEE"];
    
    return [self.dateFormatter stringFromDate:capturedStartDate];
}

- (NSDate *)dateWithDate:(NSInteger)date month:(NSInteger)month year:(NSInteger)year {
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [self.dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,date]];
}

- (NSDate *)dateWithDate:(NSDate *)date minute:(NSInteger)minute hour:(NSInteger)hour {
    NSDateComponents *todayComps = [self.dateFormatter.calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    
    NSDateComponents *comps = [self.dateFormatter.calendar components:(NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour) fromDate:date];
    comps.day = todayComps.day;
    comps.month = todayComps.month;
    comps.year = todayComps.year;
    comps.minute = minute;
    comps.hour = hour;
    
    return [self.dateFormatter.calendar dateFromComponents:comps];
}

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    [self.dateFormatter setDateFormat:format];
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)stringFromHour:(NSInteger)hour minute:(NSInteger)minute {
    NSString *amOrPm = @"AM";
    if (hour > 12) {
        amOrPm = @"PM";
    }
    return [NSString stringWithFormat:@"%ld:%ld %@", hour, minute, amOrPm];
}

@end
