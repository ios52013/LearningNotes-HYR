//
//  SecondTableViewController.m
//  popover
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "SecondTableViewController.h"
#import "ContenTableViewController.h"


@interface SecondTableViewController ()
@property(nonatomic, strong)NSMutableArray *dataSource;
@end



@implementation SecondTableViewController

//
-(NSMutableArray *)dataSource{
    if (_dataSource == NULL) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i<50; i++) {
            NSString *str = [NSString stringWithFormat:@"we are No.%d",i+1];
            [_dataSource addObject:str];
        }
    }
    return _dataSource;
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.naviTitle;
    self.preferredContentSize = CGSizeMake(300, 300);
    
    self.tableView.backgroundColor = [UIColor cyanColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.dataSource[indexPath.row]);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //1.创建内容控制器
    ContenTableViewController *contentVC = [[ContenTableViewController alloc] init];
    contentVC.content = self.dataSource[indexPath.row];
    
    //2.设置模态效果
    contentVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //3.设置弹出方向
    contentVC.popoverPresentationController.sourceView = cell;
    contentVC.popoverPresentationController.sourceRect = cell.bounds;
    
    //4.设置穿透视图
    
    //5.直接弹出
    [self presentViewController:contentVC animated:YES completion:nil];
}


@end
