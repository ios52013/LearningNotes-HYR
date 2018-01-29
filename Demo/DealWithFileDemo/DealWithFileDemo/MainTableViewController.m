//
//  MainTableViewController.m
//  DealWithFileDemo
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "MainTableViewController.h"
#import "ChoiceGroupTableViewController.h"
#import "MenuTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"当前会议";
    //导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"功能菜单" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick:)];
    //导航栏右侧按钮
    UIBarButtonItem *choiceGroupBarbutton = [[UIBarButtonItem alloc] initWithTitle:@"选择机构" style:UIBarButtonItemStylePlain target:self action:@selector(choiceGroupBarButtonClick:)];
    
    UIBarButtonItem *logoutBarbutton = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logoutBarButtonClick:)];
    self.navigationItem.rightBarButtonItems = @[logoutBarbutton,choiceGroupBarbutton];
    
}

//功能菜单
- (void)leftBarButtonClick:(UIBarButtonItem *) barButton{
    //1.创建内容控制器
    MenuTableViewController *menuVC = [[MenuTableViewController alloc] init];
    
    //2.设置模态效果
    menuVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //3.设置弹出方向
    menuVC.popoverPresentationController.barButtonItem = barButton;
    
    //4.设置穿透效果
    
    //5.直接弹出
    [self presentViewController:menuVC animated:YES completion:nil];
}

//选择机构
- (void)choiceGroupBarButtonClick:(UIBarButtonItem *) barButton{
    ChoiceGroupTableViewController *choiceGroupVC = [[ChoiceGroupTableViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:choiceGroupVC];
    [self presentViewController:navi animated:YES completion:nil];
}

//注销
- (void)logoutBarButtonClick:(UIBarButtonItem *) barButton{
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


@end
