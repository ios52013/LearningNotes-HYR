//
//  HomeViewController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "HomeViewController.h"
#import "Masonry.h"
#import "Global.h"
#import "UIControl+extension.h"


//平安统一的橘黄色
#define kORANGECOLOR [UIColor colorWithRed:238/255.0 green:115/255.0 blue:67/255.0 alpha:1]
#define kENABLECOLOR [UIColor colorWithRed:248/255.0 green:212/255.0 blue:196/255.0 alpha:1]

static UIViewController *mainViewController = nil;


@interface HomeViewController ()

@end



@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadLoginViewController];
    //  设置单例
    mainViewController = self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return  YES;
}


- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [Global interfaceOrientation];

}

/**
 *    @brief    加载会议信息界面（主界面）
 */
- (void)loadConferenceInfoView:(id)sender {
    if (sender != _loginViewController) {
        [self initConferenceInfoView];
    }
    [self.view addSubview:_conferenceInfoViewController.view];
    
    
    if (_loginViewController) {
        [_loginViewController.view removeFromSuperview];
       
    }
}

/**
 *    @brief    初始化会议信息界面
 */
- (void)initConferenceInfoView {
    if (_conferenceInfoViewController) {
        [_conferenceInfoViewController.view removeFromSuperview];
    }
    
    _conferenceInfoViewController = [[ConferenceInfoViewController alloc] init];
    [_conferenceInfoViewController initialization];
    
    //[Global hideProgressViewForType:none message:@"" afterDelay:TIPSSHOWTIME fromWindow:[Global currentWindow]];
}



/**
 *    @brief    加载登录界面
 */
- (void)loadLoginViewController {
    if (_loginViewController) {
        [_loginViewController.view removeFromSuperview];
       
    }
    
    _loginViewController = [[LoginViewController alloc] init];
    [self.view addSubview:_loginViewController.view];
}





- (void)presentGroupChoiceViewControllerWithStyle:(BOOL)isInitialSystem {
    GroupChoiceViewController *groupChoiceViewController = [[GroupChoiceViewController alloc] initWithEnvironment:isInitialSystem];
    [groupChoiceViewController setDelegate:self];
    
    [self presentViewController:groupChoiceViewController animated:YES completion:nil];
   
}

#pragma mark --------- GroupChoiceViewControllerDelegate  ---------
- (void)groupChoiceViewController:(GroupChoiceViewController *)viewController didSelectGroup:(Group *)group {
    //[Global showLoadingProgressViewWithText:@"正在进入\n请稍候..." window:viewController.view.window];
    //[Global setCurrentGroup:group];
    [self performSelector:@selector(gotoSystemWithGroupChoiceViewController:) withObject:viewController afterDelay:0.1];
}


#pragma mark ----     公有接口  ----
/**
 *    @brief    获取CDMSMainViewController类的单例
 *
 *    @return    类的当前单例对象
 */
+ (UIViewController *)sharedMainViewController {
    return mainViewController;
}

#pragma mark ----     私有接口      ----
/**
 *    @brief    屏幕转动的时候根据屏幕方向货动画持续事件来执行界面的重新布局操作
 *
 *    @param     interfaceOrientation     即将转到的界面方向
 *    @param     timeInterval     动画持续事件
 */
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)timeInterval {
#pragma mark - add by lc  MAINSCREEN_PORTRAIT_WIDTH  MAINSCREEN_LANDSCAPE_WIDTH 2个值修改过
    
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self.view setFrame:CGRectMake(0.0, MAINSCREEN_Y, MAINSCREEN_LANDSCAPE_WIDTH, MAINSCREEN_PORTRAIT_WIDTH)];
        if (_loginViewController && !_loginViewController.view.hidden)
            [(UIImageView *)_loginViewController.view setImage:[UIImage imageForName:@"login_bg_landscape" type:@"jpg"]];
    }
    else {
        [self.view setFrame:CGRectMake(0.0, MAINSCREEN_Y, MAINSCREEN_PORTRAIT_WIDTH, MAINSCREEN_LANDSCAPE_WIDTH)];
        if (_loginViewController && !_loginViewController.view.hidden)
            [(UIImageView *)_loginViewController.view setImage:[UIImage imageForName:@"login_bg_portrait" type:@"jpg"]];
    }
    
    if (_loginViewController && !_loginViewController.view.hidden)
        [_loginViewController.view setFrame:self.view.bounds];
    //[_conferenceInfoViewController relayoutForInterfaceOrientation:interfaceOrientation withDuration:timeInterval];
}


- (void)gotoSystemWithGroupChoiceViewController:(GroupChoiceViewController *)viewController {
    if (_loginViewController)
        [_loginViewController performSelector:@selector(loadContentOfConferenceViewController) withObject:nil afterDelay:0.0];
    else
        [self loadConferenceInfoView:self];
    
    [self performSelector:@selector(hideProgressViewWithWindow:) withObject:viewController.view.window afterDelay:0.1];
}

- (void)hideProgressViewWithWindow:(UIView *)view {
   // [Global hideProgressViewForType:none message:@"" afterDelay:TIPSSHOWTIME fromWindow:view];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
