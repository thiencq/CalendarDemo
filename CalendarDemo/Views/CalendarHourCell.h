//
//  CalendarHourCell.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarHourCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UIView *verticalLineView;
@property (weak, nonatomic) IBOutlet UIView *horizontalLineView;

@property (nonatomic, assign) BOOL is24h;

- (void)visualizeWithHour:(NSInteger)hour;

@end
