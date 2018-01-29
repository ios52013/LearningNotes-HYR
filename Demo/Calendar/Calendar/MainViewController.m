//
//  MainViewController.m
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "MainViewController.h"

static UIViewController *mainViewController = nil;


@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark ----     公有接口  ----
/**
 *    @brief    获取CDMSMainViewController类的单例
 *
 *    @return    类的当前单例对象
 */
+ (UIViewController *)sharedMainViewController {
    return mainViewController;
}


/**
 *    @brief    获取会议排期界面控制器对象
 *
 *    @return    会议排期界面控制器对象
 */
- (CalendarViewController *)loadCalendarView {
    if (!_calendarViewController)
        _calendarViewController = [[CalendarViewController alloc] init];
    return _calendarViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日程" style:UIBarButtonItemStylePlain target:self action:@selector(calendarButtonClick:)];
    //  设置单例
    mainViewController = self;
}

- (void)calendarButtonClick:(UIBarButtonItem *)sender {
    
    CalendarViewController *calendarViewController = [self loadCalendarView];
    [self.navigationController pushViewController:calendarViewController animated:YES];
}


@end
