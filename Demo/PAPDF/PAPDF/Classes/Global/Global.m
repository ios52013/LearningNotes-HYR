//
//  Global.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "Global.h"
#import "HomeViewController.h"



/**
 *    @brief    保存登录状态
 */
static LoginStatus loginStatus = LocalLogin;


@implementation Global

/**
 *    @brief     获取登录方式
 *
 *    @return    返回当前的登录方式（离线登录或者在线登录）
 */
+ (LoginStatus)loginStatus {
    return loginStatus;
}



/**
 *    @brief    获取当前设备方向
 *
 *    @return    当前设备方向
 */
+ (UIInterfaceOrientation)interfaceOrientation {
    return [[HomeViewController sharedMainViewController] interfaceOrientation];
}



@end
