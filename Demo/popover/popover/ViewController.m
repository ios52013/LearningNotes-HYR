//
//  ViewController.m
//  popover
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "ViewController.h"
#import "FristTableViewController.h"
#import "SecondTableViewController.h"
#import "MSGTableViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dealWithNavigation];
    [self createUI];
    
    //注册通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageChange:) name:MessageChangeNotification object:nil];
}

//接到通知触发该方法
- (void)messageChange:(NSNotification*)notification {
    self.navigationItem.title = notification.object;
    //消失popover
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //remove notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MessageChangeNotification object:nil];
}



// dealWith
- (void)dealWithNavigation{
    
    self.navigationItem.title = @"PopoverController";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarbuttonClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"资料" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarbuttonClick:)];
}

- (void)leftBarbuttonClick:(UIBarButtonItem *)sender {
    
    //    //1.create popover
    //    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:fristVC];
    //
    //    //2.
    //    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
   
    ////////////   8.0之后  /////////////////
    //1.创建内容控制器
    MSGTableViewController *msgVC = [[MSGTableViewController alloc] init];
    //2.设置模态效果
    msgVC.modalPresentationStyle = UIModalPresentationPopover;
    //2.1设置弹出方向
    msgVC.popoverPresentationController.barButtonItem = sender;
    //2.2设置穿透视图(可以与用户交互的视图)
    msgVC.popoverPresentationController.passthroughViews = @[self.view];
    //2.3设置背景颜色
    msgVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    //3.直接弹出
    [self presentViewController:msgVC animated:YES completion:nil];
   
}


- (void)rightBarbuttonClick:(UIBarButtonItem *)sender {
    //1.创建内容控制器
    FristTableViewController *fristVC = [[FristTableViewController alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:fristVC];
    
    //2.设置模态效果
    navi.modalPresentationStyle = UIModalPresentationPopover;
    
    //3.设置弹出方向
    navi.popoverPresentationController.barButtonItem = sender;
    navi.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    //4.设置穿透视图
    //fristVC.popoverPresentationController.passthroughViews
    
    //5.直接弹出
    [self presentViewController:navi animated:YES completion:nil];
}

//
- (void)createUI{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = self.view.center;
    [button setBackgroundColor:[UIColor brownColor]];
    [button setTitle:@"Click Me" forState:UIControlStateNormal];
    //
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //
    [button addTarget:self action:@selector(buttonDoubleClick:) forControlEvents:UIControlEventTouchDragOutside];
    
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender {
    //1.创建内容控制器
    FristTableViewController *fristVC = [[FristTableViewController alloc] init];
    
    //2.设置模态效果
    fristVC.modalPresentationStyle = UIModalPresentationPopover;
    
    
    //3.设置弹出方向
    fristVC.popoverPresentationController.sourceView = sender;
    fristVC.popoverPresentationController.sourceRect = sender.bounds;

    
    //4.设置穿透视图
    
    //5.直接弹出
    [self presentViewController:fristVC animated:YES completion:nil];
}


- (void)buttonDoubleClick:(UIButton *)sender {
    //1.创建内容控制器
    MSGTableViewController *messageVC = [[MSGTableViewController alloc] init];
    
    //2.设置模态效果
    messageVC.modalPresentationStyle = UIModalPresentationPopover;
    
    
    //3.设置弹出方向
    messageVC.popoverPresentationController.sourceView = self.view;
    messageVC.popoverPresentationController.sourceRect = sender.frame;
    messageVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
    //4.设置穿透视图
    
    
    //5.直接弹出
    [self presentViewController:messageVC animated:YES completion:nil];
}


@end
