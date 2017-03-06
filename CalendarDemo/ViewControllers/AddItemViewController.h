//
//  AddItemViewController.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddItemViewController;

@protocol AddItemViewControllerDelegate <NSObject>

- (void)addItemViewController:(AddItemViewController *)controller didSelectStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end

@interface AddItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *dragableView;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, weak) id<AddItemViewControllerDelegate>delegate;

- (IBAction)doneItemTouched:(id)sender;

@end
