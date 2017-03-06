//
//  AddItemViewController.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "AddItemViewController.h"
#import "CalendarHourCell.h"
#import "Helper.h"

static NSString *const kCalendarHourCell = @"CalendarHourCell";
static NSInteger kTableViewCellHeight = 60;

@interface AddItemViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, strong) Helper *helper;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupGesture];
    self.helper = [Helper instance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGesture {
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.tableView addGestureRecognizer:self.tapGesture];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.dragableView addGestureRecognizer:self.panGesture];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    CGPoint tapLocation = [tapGesture locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath) {
        CalendarHourCell *hourCell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        CGRect frame = hourCell.frame;
        frame.origin.x = hourCell.verticalLineView.frame.origin.x + 1;
        frame.origin.y += hourCell.horizontalLineView.frame.origin.y + 1;
        frame.size.height -= 2;
        
        self.dragableView.frame = frame;
    }
    
    [self.dragableView removeFromSuperview];
    [self.tableView addSubview:self.dragableView];
    
    self.hourLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.helper stringFromHour:(indexPath.row) minute: 0], [self.helper stringFromHour:(indexPath.row + 1) minute: 0]];
    
    self.startDate = [self.helper dateWithDate:self.currentDate minute:0 hour:(indexPath.row)];
    self.endDate = [self.helper dateWithDate:self.currentDate minute:0 hour:(indexPath.row + 1)];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    UIGestureRecognizerState state = panGesture.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.currentPoint = self.dragableView.center;
    } else if (state == UIGestureRecognizerStateFailed ||
               state == UIGestureRecognizerStateCancelled) {
        self.dragableView.center = self.currentPoint;
    }
    else if (state == UIGestureRecognizerStateEnded) {
        CGPoint location = [panGesture locationInView:self.tableView];
        [self updateDragableViewLocationWithLocation:location];
    }
             
    else {
        CGPoint location = [panGesture locationInView:self.tableView];
        self.dragableView.center = location;
    }
}

- (void)updateDragableViewLocationWithLocation:(CGPoint)location {
    CGFloat viewTop = location.y - kTableViewCellHeight/2;
    
    // First cell
    if (viewTop < 0) {
        viewTop = 0;
    }
    
    CGPoint viewTopPoint = CGPointMake(location.x, viewTop);
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:viewTopPoint];
    
    CalendarHourCell *hourCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat delta = viewTopPoint.y - hourCell.frame.origin.y;
    CGFloat scale = delta/kTableViewCellHeight;
    CGFloat dy = 0;
    NSInteger minute = 0;
    NSInteger hour = 0;
    
    if (scale < 0.2) {
        dy = 0;
    }
    else if (scale < 0.4) {
        dy = kTableViewCellHeight/4;
        minute = 15;
    }
    else if (scale < 0.6) {
        dy = kTableViewCellHeight/2;
        minute = 30;
    }
    else if (scale < 0.8) {
        dy = kTableViewCellHeight*3/4;
        minute = 45;
    }
    else {
        dy = kTableViewCellHeight;
        hour = 1;
    }
    
    // Calculate the position for dragview
    CGRect frame = hourCell.frame;
    frame.origin.x = hourCell.verticalLineView.frame.origin.x + 1;
    frame.origin.y += hourCell.horizontalLineView.frame.origin.y + 1 + dy;
    frame.size.height -= 2;
    
    self.dragableView.frame = frame;
    
    // Update hour label
    self.hourLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.helper stringFromHour:(indexPath.row) + hour minute: minute], [self.helper stringFromHour:(indexPath.row + hour + 1) minute: minute]];
    
    self.startDate = [self.helper dateWithDate:self.currentDate minute:minute hour:(indexPath.row + hour)];
    self.endDate = [self.helper dateWithDate:self.currentDate minute:minute hour:(indexPath.row + hour + 1)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource's methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalendarHourCell *hourCell = (CalendarHourCell *)[tableView dequeueReusableCellWithIdentifier:kCalendarHourCell forIndexPath:indexPath];
    
    [hourCell visualizeWithHour:indexPath.row];
    
    return hourCell;
}

#pragma mark - UITableViewDelegate's methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewCellHeight;
}

- (IBAction)doneItemTouched:(id)sender {
    if (!self.startDate || !self.endDate) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please select start time and end time" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addItemViewController:didSelectStartDate:endDate:)]) {
        [self.delegate addItemViewController:self didSelectStartDate:self.startDate endDate:self.endDate];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
