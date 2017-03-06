//
//  Helper.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/3/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (instancetype)instance;

- (NSString *)getCurrentDate;

- (NSString *)getCurrentMonth;

- (NSString *)getCurrentYear;

- (NSString *)getCurrentDay;

- (NSString *)getMonthString:(NSInteger)index;

- (NSArray *)daysInWeeks;

- (NSString *)getDayString:(NSInteger)index;

- (NSInteger)getDaysInMonth:(NSInteger)month year:(NSInteger)year;

- (NSString *)getDayOfDate:(NSInteger)date month:(NSInteger)month year:(NSInteger)year;

- (NSString *)stringFromHour:(NSInteger)hour minute:(NSInteger)minute;

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

- (NSDate *)dateWithDate:(NSInteger)date month:(NSInteger)month year:(NSInteger)year;

- (NSDate *)dateWithDate:(NSDate *)date minute:(NSInteger)minute hour:(NSInteger)hour;

@end
