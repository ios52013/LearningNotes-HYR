//
//  ChoiceGroupTableViewController.m
//  DealWithFileDemo
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "ChoiceGroupTableViewController.h"

@interface ChoiceGroupTableViewController ()
@property(nonatomic, strong)NSArray *dataArr;
@end

@implementation ChoiceGroupTableViewController


-(NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = @[@"平安科技(PINGAN TECHNOLOGY)",@"集团总公司(test)"];
    }
    return _dataArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"公司选择";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canCelBtnClick:)];
}

- (void)canCelBtnClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}



@end
