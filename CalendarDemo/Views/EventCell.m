//
//  EventCell.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "EventCell.h"
#import "Helper.h"

@implementation EventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)visualizeWithModel:(EventModel *)model {
    NSString *format = @"hh:mm dd-MMM-yyyy";
    self.startDateLabel.text = [[Helper instance] stringFromDate:model.startDate format:format];
    self.endDateLabel.text = [[Helper instance] stringFromDate:model.endDate format:format];
}

@end
