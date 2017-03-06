//
//  ViewController.h
//  CalendarDemo
//
//  Created by Thien Chu on 3/3/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

- (void)viewController:(ViewController *)controller didSelectStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) id<ViewControllerDelegate>delegate;

- (IBAction)previousButtonTouched:(id)sender;
- (IBAction)nextButtonTouched:(id)sender;

- (IBAction)doneItemTouched:(id)sender;


@end

