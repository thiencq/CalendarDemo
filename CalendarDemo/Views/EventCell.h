//
//  EventCell.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *startDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

- (void)visualizeWithModel:(EventModel *)model;

@end
