//
//  CalendarDayCell.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/3/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDayCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)visualzieWithTitle:(NSString *)title;

@end
