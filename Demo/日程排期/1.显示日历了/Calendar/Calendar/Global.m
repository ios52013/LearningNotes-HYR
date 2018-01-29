//
//  Global.m
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "Global.h"
#import "MainViewController.h"

@implementation Global


/**
 *    @brief    获取当前设备方向
 *
 *    @return    当前设备方向
 */
+ (UIInterfaceOrientation)interfaceOrientation {
    return [[MainViewController sharedMainViewController] interfaceOrientation];
}


@end
