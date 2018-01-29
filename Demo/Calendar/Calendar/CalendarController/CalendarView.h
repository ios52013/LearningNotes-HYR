//
//  CalendarView.h
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <UIKit/UIKit.h>




//定义Portrait日历
//日历显示

#define CALENDARVIEW_PORTAIR_X            105.0
#define CALENDARVIEW_PORTAIR_Y            270.0
#define CALENDARVIEW_PORTAIR_WIDTH        560.0     //日历为7列，每列为80宽
#define CALENDARVIEW_PORTAIR_HEIGHT       100.0     //日历为6行，每行为100高
//const float kCalendar_Portair_ItemHeight=100.0;     //行高
////////////////////

//定义Landscape日历

//日历显示
#define CALENDARVIEW_LANDSCAPE_X            125.0
#define CALENDARVIEW_LANDSCAPE_Y            224.0
#define CALENDARVIEW_LANDSCAPE_WIDTH        777.0     //日历为7列，每列为100宽
#define CALENDARVIEW_LANDSCAPE_HEIGHT       77.0     //每行为77高
//const float kCalendar_Landscape_ItemHeight=84.0;      //行高


#define CALENDARVIEW_MARKICON_LANDSCAPE_X    85.0
#define CALENDARVIEW_MARKICON_LANDSCAPE_Y     10.0

#define CALENDARVIEW_MARKICON_PORTRAIT_X       85.0
#define CALENDARVIEW_MARKICON_PORTRAIT_Y       10.0

#define CALENDARVIEW_MARKICON_WIDTH       21.0
#define CALENDARVIEW_MARKICON_HEIGHT      24.0


#define DayFont    26


@protocol CalendarViewDelegate;

@interface CalendarView : UIView
{
    
    CFGregorianDate currentMonthDate;                 // 当前年月日
    CFGregorianDate currentSelectDate;                // 当前选择日期
    CFAbsoluteTime    currentTime;                      // 当前时间
    UIImageView* viewImageView;                       //
    int numWeeksForSelectedDate;                      //
    //id<CSCalendarViewDelegate> _delegate;             //
    
    CGPoint _touchBeginPoint;                         //
    BOOL _isTouchMove;                                //
    BOOL isDrawScheduleMark;                          //
    BOOL isAllMonth;                                  //
    
    NSMutableArray *_toMarkDayDataSource;             //
    NSMutableArray *_toSelectedDayDataSource;         //
    
    CGRect popRect;                                   //
    UIPopoverController *_popoverController;          //
    BOOL istouch;                                     //
    BOOL _isPre;                                      //
    BOOL _selectedDateHasSchedule;                    //
}
@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;

@property (nonatomic, retain) UIImageView* viewImageView;
@property (nonatomic,readwrite)int numWeeksForSelectedDate;
@property (nonatomic,assign) BOOL isDrawScheduleMark;
@property (nonatomic,assign) BOOL isAllMonth;
@property (nonatomic,assign) BOOL isPre;
@property (nonatomic, assign) id<CalendarViewDelegate> delegate;

@property (nonatomic,retain) NSArray *testArray;
@property (nonatomic,retain) UIPopoverController *popoverController;
@property (nonatomic,retain)  NSMutableArray *toSelectedDayDataSource;
@property (nonatomic,retain) NSMutableArray *toMarkDayDataSource;
- (void)drawMarkByArray:(NSArray *)array;

- (void)setToday;//返回今天所在日期包含多少个星期
- (int)getDayCountOfaMonth:(CFGregorianDate)date;//返回指定日期月份所在的天数 ／／／／
- (int)getMonthWeekday:(CFGregorianDate)date;//返回指定日期月份的第一天所在的星期 ／／／／
- (void)movePrevMonthWithSelectedDay:(int)seletedDay prevYearOrMonth:(NSString*)prevYearOrMonth;
- (void)moveNextMonthWithSelectedDay:(int)seletedDay nextYearOrMonth:(NSString*)nextYearOrMonth;

- (void) movePrevNext:(int)isPrev SelectedDay:(int)selectedDay;

@end

@protocol CalendarViewDelegate<NSObject>
@optional


- (BOOL)selectDateChanged:(CFGregorianDate)selectDate;
- (void)monthChanged:(CFGregorianDate)currentCalendarDate;

- (void)changedFrameWhenPreOrNext;

- (void)didFinishDrawingCalendarView:(CalendarView *)calendarView;
@end



