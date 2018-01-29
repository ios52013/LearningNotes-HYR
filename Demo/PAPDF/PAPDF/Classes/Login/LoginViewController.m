//
//  LoginViewController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "HomeViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void) createUI{
    UIButton *loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor cyanColor]];
    [loginButton addTarget:self action:@selector(loadGroupChoiceViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark 登录成功
- (void)loadGroupChoiceViewController {
    HomeViewController *mainViewController = (HomeViewController *)[HomeViewController sharedMainViewController];
    [mainViewController presentGroupChoiceViewControllerWithStyle:YES];
    
}


/**
 *    @brief     加载会议信息界面
 */
- (void)loadContentOfConferenceViewController {
    HomeViewController *mainViewController = (HomeViewController *)[HomeViewController sharedMainViewController];
    [mainViewController initConferenceInfoView];
    //[self performSelector:@selector(goIntoSystem) withObject:nil afterDelay:2];
    //modify 登陆后如果有多个机构，选择任意机构跳转到登陆页面再进入机构 by jay  2016 03 30
    [self performSelector:@selector(goIntoSystem) withObject:nil afterDelay:0];
}

/**
 *    @brief     进入系统，进入会议信息界面
 */
- (void)goIntoSystem {
    
    [self.view setUserInteractionEnabled:YES];
    [(HomeViewController *)[HomeViewController sharedMainViewController] loadConferenceInfoView:self];
}



@end
