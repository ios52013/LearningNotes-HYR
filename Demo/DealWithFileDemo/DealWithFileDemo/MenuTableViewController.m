//
//  MenuTableViewController.m
//  DealWithFileDemo
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "MenuTableViewController.h"
#import "PersonTableViewController.h"
#import "DiaryTableViewController.h"
#import "HistoryTableViewController.h"
#import "CalendarTableViewController.h"
#import "RootTableViewController.h"


@interface MenuTableViewController ()
@property(nonatomic, strong) NSArray *menuArr;
@end

@implementation MenuTableViewController

-(NSArray *)menuArr{
    if (_menuArr == nil) {
        _menuArr = @[@"个人文件",@"日常文件",@"历史会议文件",@"会议排期"];
    }
    return _menuArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //修改大小
    self.preferredContentSize = CGSizeMake(150, 200);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.menuArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RootTableViewController *VC = nil;
    switch (indexPath.row) {
        case 0:
            VC = [[PersonTableViewController alloc] init];
            break;
        case 1:
            VC = [[DiaryTableViewController alloc] init];
            break;
        case 2:
            VC = [[HistoryTableViewController alloc] init];
            break;
        case 3:
            VC = [[CalendarTableViewController alloc] init];
            break;
            
        default:
            break;
    }
    
    VC.content = self.menuArr[indexPath.row];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:VC];
    
    [self presentViewController:navi animated:YES completion:nil];
}

@end
