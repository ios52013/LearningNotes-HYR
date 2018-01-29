//
//  CalendarViewController.h
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"


//定义Portrait日历
//定义显示年月的label
#define CALENDARMONTHLABEL_PORTAIR_X            265.0
#define CALENDARMONTHLABEL_PORTAIR_Y            150.0
#define CALENDARMONTHLABEL_PORTAIR_WIDTH        240.0
#define CALENDARMONTHLABEL_PORTAITR_HEIGHT       50.0
//显示星期的label
#define kCalendarWeekdayTitleColor             [UIColor colorWithRed:245/255.0 green:220/255.0 blue:185/255.0 alpha:1.0f]
#define CALENDARWEEKLABEL_PORTAIT_X            105.0
#define CALENDARWEEKLABEL_PORTAIT_Y            225.0
#define CALENDARWEEKLABEL_PORTAIT_WIDTH        560.0
#define CALENDARWEEKLABEL_PORTAIT_HEIGHT       45.0
//前后项button
#define CALENDARPREBUTTON_PORTRAIT_X           38.0
#define CALENDARNEXTBUTTON_PORTRAIT_X       675.0
#define CALENDARBUTTON_PORTRAIT_Y           509.0
///////////////

#define CALENDARBUTTON_WIDTH        60.0
#define CALENDARBUTTON_HEIGHT       60.0

//定义Landscape日历
//定义显示年月的label
#define CALENDARMONTHLABEL_LANDSCAPE_X            375.0
#define CALENDARMONTHLABEL_LANDSCAPE_Y            130.0
#define CALENDARMONTHLABEL_LANDSCAPE_WIDTH        250.0
#define CALENDARMONTHLABEL_LANDSCAPE_HEIGHT       35.0
//显示星期的label
#define CALENDARWEEKLABEL_LANDSCAPE_X            125.0
#define CALENDARWEEKLABEL_LANDSCAPE_Y            180.0
#define CALENDARWEEKLABEL_LANDSCAPE_WIDTH        777.0
#define CALENDARWEEKLABEL_LANDSCAPE_HEIGHT       44.0
//前后项button
#define CALENDARPREBUTTON_LANDSCAPE_X       51.0
#define CALENDARNEXTBUTTON_LANDSCAPE_X      918.0
#define CALENDARBUTTON_LANDSCAPE_Y           385.0

#define kWeekLabelTag  500
#define kMonthLabelTeg 700
#define kDateYear                  @"dateYear"
#define kDateMonth              @"dateMonth"
#define kDateDay                    @"dateDay"



@interface CalendarViewController : UIViewController
{
    
    CalendarView *_csCalendarView;                    // 日历控件
    UIImageView *_backgroundImageView;                  // 背景图片
    UILabel *_calendarMonthLabel;                       // 月份显示
    UIButton *_calendarPreButton;                       // 前一月按钮
    UIButton *_calendarNextButton;                      // 后一月按钮
    NSMutableArray *_monthScheduleDatasource;           // 当月排期数据源
    NSDate *_selectedDate;                              // 当前所选日期
    
    int _selectedYear;                                  // 当前所选年
    int _selectedMonth;                                 // 当前所选月
    int _selectedDay;                                   // 当前所选日
    int requestYear;                                    // 请求的年份
    int requestMonth;                                   // 请求的月份
    
    UIView *_contentView;                               // 内容视图
}

@property (nonatomic,retain) CalendarView *csCalendarView;
@property (nonatomic,retain) UIImageView *backgroundImageView;
@property (nonatomic,retain) UILabel *calendarMonthLabel;
@property (nonatomic,retain) UIButton *calendarPreButton;
@property (nonatomic,retain) UIButton *calendarNextButton;
@property (nonatomic,retain) NSMutableArray *monthScheduleDatasource;
@property (nonatomic,retain) NSDate *selectedDate;
@end
