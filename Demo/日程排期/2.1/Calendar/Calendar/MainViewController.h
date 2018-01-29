//
//  MainViewController.h
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewController.h"

@interface MainViewController : UIViewController
{
    CalendarViewController *_calendarViewController;  // 会议排期界面
}


/**
 *    @brief    获取CDMSMainViewController类的单例
 *
 *    @return    类的当前单例对象
 */
+ (UIViewController *)sharedMainViewController;
/**
 *    @brief    获取会议排期界面控制器对象
 *
 *    @return    会议排期界面控制器对象
 */
- (CalendarViewController *)loadCalendarView;

@end
