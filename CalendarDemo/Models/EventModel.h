//
//  EventModel.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end
