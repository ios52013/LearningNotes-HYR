//
//  MainViewController.m
//  可选择的日历
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日程排期" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
}

- (void)back:(UIBarButtonItem *)sender {
    
    ViewController *viewController = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
