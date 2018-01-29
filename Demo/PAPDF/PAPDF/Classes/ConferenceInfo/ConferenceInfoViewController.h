//
//  ConferenceInfoViewController.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//


/**
 *    @brief    会议信息界面控制器类，提供未读通知信息列表显示，会议信息显示，以及个人文件，日常文件，历史会议的入口，为登录系统后的主界面
 */


#import "ContentViewController.h"

@interface ConferenceInfoViewController : ContentViewController


/**
 *    @brief    初始化操作，请求通知附件信息，上传未上传阅读状态的通知状态，请求会议信息，请求通知信息
 */
- (void)initialization;


@end
