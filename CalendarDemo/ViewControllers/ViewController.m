//
//  ViewController.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/3/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "ViewController.h"
#import "CalendarDayCell.h"
#import "Helper.h"
#import "AddItemViewController.h"


static NSString *const kCalendarDayCellIdentifier = @"CalendarDayCell";
const CGFloat kSpacing = 5;

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddItemViewControllerDelegate>

@property (nonatomic, strong) NSArray *daysInWeeks;
@property (nonatomic, assign) NSInteger monthToLoad;
@property (nonatomic, assign) NSInteger yearToLoad;
@property (nonatomic, strong) Helper *helper;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.helper = [Helper instance];
    
    self.daysInWeeks = @[@"SUN", @"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT"];
    self.monthToLoad = [[self.helper getCurrentMonth] integerValue];
    self.yearToLoad = [[self.helper getCurrentYear] integerValue];
    self.titleLabel.text = [[self.helper getMonthString:self.monthToLoad] uppercaseString];
    
    self.currentDate = [NSDate date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarCollectionView reloadData];
        self.titleLabel.text = [[self.helper getMonthString:self.monthToLoad] uppercaseString];
    });
}

#pragma mark - UICollectionViewDataSource's methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.daysInWeeks.count;
    }
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarDayCell *cell = (CalendarDayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCalendarDayCellIdentifier forIndexPath:indexPath];
    
    NSString *title = @"";
    if (indexPath.section == 0) {
        title = self.daysInWeeks[indexPath.row];
    }
    
    else {
        NSInteger daysInMonth = [self.helper getDaysInMonth:self.monthToLoad year:self.yearToLoad];
        NSInteger firstDay = [[self.helper daysInWeeks] indexOfObject:[[Helper instance] getDayOfDate:1 month:self.monthToLoad year:self.yearToLoad]];
        
        if (indexPath.row >= firstDay && indexPath.row < (firstDay + daysInMonth)) {
            title = [NSString stringWithFormat:@"%ld", indexPath.row - firstDay + 1];
        }
        
        if ([[self.helper getCurrentDate] integerValue] == indexPath.row - firstDay + 1) {
            [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
    
    [cell visualzieWithTitle:title];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout's methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(collectionView.frame) - 6 * kSpacing)/ 7;
    
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    
    NSInteger daysInMonth = [self.helper getDaysInMonth:self.monthToLoad year:self.yearToLoad];
    NSInteger firstDay = [[self.helper daysInWeeks] indexOfObject:[[Helper instance] getDayOfDate:1 month:self.monthToLoad year:self.yearToLoad]];
    
    if (indexPath.row < firstDay && indexPath.row >= (firstDay + daysInMonth)) {
        return;
    }
    NSInteger date = indexPath.row - firstDay + 1;
    self.currentDate = [self.helper dateWithDate:date month:self.monthToLoad year:self.yearToLoad];
}

#pragma mark - IBAction

- (IBAction)previousButtonTouched:(id)sender {
    if (self.monthToLoad == 1) {
        self.monthToLoad = 12;
        self.yearToLoad -= 1;
    }
    else {
        self.monthToLoad -= 1;
    }
    [self reloadData];
}

- (IBAction)nextButtonTouched:(id)sender {
    if (self.monthToLoad == 12) {
        self.monthToLoad = 1;
        self.yearToLoad += 1;
    }
    else {
        self.monthToLoad += 1;
    }
    [self reloadData];
}

- (IBAction)doneItemTouched:(id)sender {
    if (!self.startDate || !self.endDate) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please select start time and end time" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didSelectStartDate:endDate:)]) {
        [self.delegate viewController:self didSelectStartDate:self.startDate endDate:self.endDate];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AddItemViewController class]]) {
        AddItemViewController *addItemViewController = segue.destinationViewController;
        addItemViewController.currentDate = self.currentDate;
        addItemViewController.delegate = self;
    }
}

#pragma mark - AddItemViewControllerDelegate's methods
- (void)addItemViewController:(AddItemViewController *)controller didSelectStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    self.startDate = startDate;
    self.endDate = endDate;
}

@end
