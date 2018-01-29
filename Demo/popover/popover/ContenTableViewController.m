//
//  ContenTableViewController.m
//  popover
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "ContenTableViewController.h"

@interface ContenTableViewController ()
@property(nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation ContenTableViewController

//
-(void)setContent:(NSString *)content{
    _content = content;
    self.dataArr = [[content componentsSeparatedByString:@" "] mutableCopy];
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.preferredContentSize = CGSizeMake(200, 200);
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
