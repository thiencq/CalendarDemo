//
//  CalendarHourCell.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "CalendarHourCell.h"

@implementation CalendarHourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.is24h = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)visualizeWithHour:(NSInteger)hour {
    if (self.is24h) {
        self.hourLabel.text = [NSString stringWithFormat:@"%ld", hour];
        return;
    }
    
    NSString *amOrPm = @"AM";
    
    NSInteger hourToDisplay = hour;
    
    if (hour > 12) {
        amOrPm = @"PM";
        hourToDisplay = hour%12;
    }
    self.hourLabel.text = [NSString stringWithFormat:@"%ld %@", hourToDisplay, amOrPm];
}

@end
