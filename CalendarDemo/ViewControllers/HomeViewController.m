//
//  HomeViewController.m
//  CalendarDemo
//
//  Created by Thien Chu on 3/4/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "EventCell.h"
#import "Helper.h"
#import "EventModel.h"

static NSString *const kEventCell = @"EventCell";

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, ViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dateList;
@property (nonatomic, strong) Helper *helper;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateList = [NSMutableArray new];
    self.helper = [Helper instance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource's methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:kEventCell forIndexPath:indexPath];
    
    [cell visualizeWithModel:self.dateList[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate's methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
        ViewController *viewController = segue.destinationViewController;
        viewController.delegate = self;
    }
    
}


#pragma mark - ViewControllerDelegate's methods
- (void)viewController:(ViewController *)controller didSelectStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    EventModel *model = [EventModel new];
    model.startDate = startDate;
    model.endDate = endDate;
    
    [self.dateList addObject:model];
    
    [self reloadData];
}

@end
