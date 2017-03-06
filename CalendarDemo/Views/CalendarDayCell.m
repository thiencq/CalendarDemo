//
//  CalendarDayCell.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/3/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "CalendarDayCell.h"

@implementation CalendarDayCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)visualzieWithTitle:(NSString *)title {
    self.titleLabel.text = title;
    
    [self.iconImageView setHidden:(title.length == 0)];
    
    if ([title integerValue] == 0) {
        self.titleLabel.textColor = [UIColor redColor];
        [self.iconImageView setHidden:YES];
    }
}

@end
