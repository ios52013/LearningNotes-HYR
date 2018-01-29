//
//  FristTableViewController.m
//  popover
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "FristTableViewController.h"
#import "SecondTableViewController.h"



@interface FristTableViewController ()
//
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation FristTableViewController


//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
-(NSMutableArray *)dataArr{
    if (_dataArr == NULL) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i<100; i++) {
            NSString *title = [NSString stringWithFormat:@"菜单：%d",i+1];
            [_dataArr addObject:title];
        }
    }
    return _dataArr;
}



//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"第一个控制器";
    self.preferredContentSize = CGSizeMake(150, 300);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //发通知
    SecondTableViewController *secondVC = [[SecondTableViewController alloc] init];
    secondVC.naviTitle = self.dataArr[indexPath.row];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
