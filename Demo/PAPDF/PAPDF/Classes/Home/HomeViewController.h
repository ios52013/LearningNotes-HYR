//
//  HomeViewController.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupChoiceViewController.h"
#import "LoginViewController.h"
#import "ConferenceInfoViewController.h"

@interface HomeViewController : UIViewController <GroupChoiceViewControllerDelegate>


@property(nonatomic, strong) LoginViewController *loginViewController;     // 登录界面
@property(nonatomic, strong) ConferenceInfoViewController *conferenceInfoViewController;  // 会议信息界面


/**
 *    @brief    获取MainViewController类的单例
 *
 *    @return    类的当前单例对象
 */
+ (UIViewController *)sharedMainViewController;

/**
 *    @brief    加载登录界面
 */
- (void)loadLoginViewController;


/**
 *    @brief    初始化会议信息界面
 */
- (void)initConferenceInfoView;

/**
 *    @brief    加载会议信息界面（主界面）
 */
- (void)loadConferenceInfoView:(id)sender;


/**
 *    @brief    根据环境弹出groupViewController，如果是初始化系统时弹出，则不提供取消按钮，如果在主界面通过用户主动选择弹出，提供取消按钮
 *
 *    @param     isInitialSystem 是否是初始化的时候弹出
 */
- (void)presentGroupChoiceViewControllerWithStyle:(BOOL)isInitialSystem;


@end
