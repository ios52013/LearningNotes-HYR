//
//  MSGTableViewController.m
//  popover
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "MSGTableViewController.h"

@interface MSGTableViewController ()
//
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation MSGTableViewController

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
-(NSMutableArray *)dataArr{
    if (_dataArr == NULL) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i<100; i++) {
            NSString *title = [NSString stringWithFormat:@"这是第:%d条消息",i+1];
            [_dataArr addObject:title];
        }
    }
    return _dataArr;
}
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(200, 300);
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:MessageChangeNotification object:self.dataArr[indexPath.row] userInfo:nil];
}

@end
