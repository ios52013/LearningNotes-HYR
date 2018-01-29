//
//  CommonViewController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "CommonViewController.h"
#import "UIControl+extension.h"
#import "Global.h"
#import "UIViewExt.h"

@interface CommonViewController ()

@end

@implementation CommonViewController
/**
 *    @brief    加载顶部导航条
 */
- (void)loadNavigationBar {
    CGFloat barWidth = 0.0;
    CGFloat titleWidth = 0.0;
    if (UIInterfaceOrientationIsLandscape([Global interfaceOrientation])) {
        barWidth = 1024.0;
        titleWidth = NAVBAR_TITLE_L_X;
    }
    else {
        barWidth = 768.0;
        titleWidth = NAVBAR_TITLE_P_X;
    }
    _navigationBar = [[HYRToolBar alloc] initWithFrame:CGRectMake(0.0, 0.0, barWidth, TITLE_BAR_HEIGHT)];
    [_navigationBar setBackgroundImage:[UIImage imageForName:@"titlebar_portrait_bg" type:@"png"]];
    [_navigationBar.titleLabel setFrame:CGRectMake(titleWidth,
                                                   NAVBAR_TITLE_Y,
                                                   NAVBAR_TITLE_WIDTH,
                                                   NAVBAR_TITLE_HEIGHT)];
    [[_navigationBar titleLabel] setTextColor:TITLE_AND_CONTENT_TEXTCOLOR];
    [[_navigationBar titleLabel] setFont:BOLDSYSTEMFONT(25)];
    [self.view addSubview:_navigationBar];
}


#pragma mark --------程序扩展     --------
/**
 *    @brief    横竖屏切换时重先布局界面元素
 *
 *    @param     interfaceOrientation     当前屏幕方向
 *    @param     duration     横竖屏切换的动画时间
 */
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration{
    
    
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {//横屏
        //    [self.view setFrame:CGRectMake(0.0, 0.0, MAINSCREEN_LANDSCAPE_WIDTH,MAINSCREEN_LANDSCAPE_HEIGHT)];
        [_navigationBar setFrame:CGRectMake(0.0, 0.0, 1024.0, TITLE_BAR_HEIGHT)];
        [_navigationBar setBackgroundImage:[UIImage imageForName:@"titlebar_landscape_bg" type:@"png"]];
        [_navigationBar.titleLabel setFrame:CGRectMake(NAVBAR_TITLE_L_X,
                                                       NAVBAR_TITLE_Y,
                                                       NAVBAR_TITLE_WIDTH,
                                                       NAVBAR_TITLE_HEIGHT)];
#pragma mark - add by lc
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.navigationBar.top += 20;
        }
        
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageForName:@"main_landscape_bg" type:@"jpg"]]];
    }
    else{//竖屏
        //    [self.view setFrame:CGRectMake(0.0, 0.0, MAINSCREEN_PORTRAIT_WIDTH, MAINSCREEN_PORTRAIT_HEIGHT)];
        [_navigationBar setFrame:CGRectMake(0.0, 0.0, 768.0, TITLE_BAR_HEIGHT)];
        [_navigationBar setBackgroundImage:[UIImage imageForName:@"titlebar_portrait_bg" type:@"png"]];
        [_navigationBar.titleLabel setFrame:CGRectMake(NAVBAR_TITLE_P_X,
                                                       NAVBAR_TITLE_Y,
                                                       NAVBAR_TITLE_WIDTH,
                                                       NAVBAR_TITLE_HEIGHT)];
#pragma mark - add by lc
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.navigationBar.top += 20;
        }
        
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageForName:@"main_portrait_bg" type:@"jpg"]]];
    }
}


#pragma mark --------系统自带  --------

- (void)loadView{
    UIView *selfView = [[UIView alloc] init];
    [self setView:selfView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //  [self.view setFrame:CGRectMake(0.0, 0.0, MAINSCREEN_PORTRAIT_WIDTH, MAINSCREEN_PORTRAIT_HEIGHT)];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageForName:@"main_portrait_bg" type:@"jpg"]]];
    [self loadNavigationBar];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
#pragma mark - add by lc
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}
#pragma end


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    if (_navigationBar)
        _navigationBar = nil;
}

@end
