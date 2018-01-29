//
//  CalendarViewController.m
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "CalendarViewController.h"
#import "UIControl+extension.h"
#import "Global.h"


@interface CalendarViewController ()

@end




@implementation CalendarViewController


/**
 *    @brief    横屏布局
 */
- (void)layoutElementsForLandscape {
    _backgroundImageView.frame = CGRectMake(CONTENTVIEW_LANDSCAPE_X, CONTENTVIEW_Y, CONTENTVIEW_LANDSCAPE_WIDTH, CONTENTVIEW_LANDSCAPE_HEIGHT);
    [_backgroundImageView setImage:[UIImage imageForName:@"content_landscape_bg" type:@"png"]];
    [self loadCalendarMonthLabelIfLandscape:YES];
    [self loadCalendarWeekLabelIfLandscape:YES];
    [self loadViewIfLandscape:YES];
    [self loadCalendarButtonIfLandscape:YES];
    
}

/**
 *    @brief    竖屏布局
 */
- (void)layoutElementsForPortrait {
    
    _backgroundImageView.frame = CGRectMake(CONTENTVIEW_PORTRAIT_X, CONTENTVIEW_Y, CONTENTVIEW_PORTRAIT_WIDTH, CONTENTVIEW_PORTRAIT_HEIGHT);
    [_backgroundImageView setImage:[UIImage imageForName:@"content_portrait_bg" type:@"png"]];
    [self loadCalendarMonthLabelIfLandscape:NO];
    [self loadCalendarWeekLabelIfLandscape:NO];
    [self loadViewIfLandscape:NO];
    //    [self loadCalendarViewIfLandscape:NO];
    [self loadCalendarButtonIfLandscape:NO];
    
}

/**
 *    @brief    加载navigationBar上的全部按钮和bar标题
 */
- (void)loadNavigatioBarButtonAddTitle {
    
    self.navigationItem.title = @"会议排期";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(conferenceInfoBtnClick:)];
    
}



#pragma mark --------加载日历控键 --------
- (void)loadViewIfLandscape:(BOOL)isLandscape {
    int n ;
    if (_csCalendarView.isPre) n = 0;
    else n =1;
    int count = ([_csCalendarView getDayCountOfaMonth:_csCalendarView.currentMonthDate]+[_csCalendarView getMonthWeekday:_csCalendarView.currentMonthDate]-2)/7+1;
    if (isLandscape) {
        _contentView.frame = CGRectMake(CALENDARVIEW_LANDSCAPE_X, CALENDARVIEW_LANDSCAPE_Y, CALENDARVIEW_LANDSCAPE_WIDTH, CALENDARVIEW_LANDSCAPE_HEIGHT*count);
        _csCalendarView.frame = CGRectMake(0, 0, CALENDARVIEW_LANDSCAPE_WIDTH, CALENDARVIEW_LANDSCAPE_HEIGHT*count);
    }
    else {
        _contentView.frame = CGRectMake(CALENDARVIEW_PORTAIR_X, CALENDARVIEW_PORTAIR_Y, CALENDARVIEW_PORTAIR_WIDTH, CALENDARVIEW_PORTAIR_HEIGHT*count);
        _csCalendarView.frame = CGRectMake(0, 0, CALENDARVIEW_PORTAIR_WIDTH, CALENDARVIEW_PORTAIR_HEIGHT*count);
        
    }
    [_csCalendarView movePrevNext:n SelectedDay:1];
}


/**
 *    @brief    初始化所有日历视图
 */
- (void)initAllCalendarViews {
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_backgroundImageView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_contentView];
    
    _csCalendarView = [[CalendarView alloc] initWithFrame:CGRectZero];
    [_contentView addSubview:_csCalendarView];
    [_contentView setClipsToBounds:YES];
    _csCalendarView.delegate = self;
    [_csCalendarView setNeedsDisplay];
    
    _calendarMonthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_calendarMonthLabel];
    
    _calendarPreButton = [UIButton buttonWithFrame:CGRectZero
                                              title:nil
                                        normalImage:[UIImage imageNamed:@"scheduleBtnN.png"] highlightImage:[UIImage imageNamed:@"scheduleBtnH1.png"] selectedImage:nil
                                               font:nil
                                             target:self
                                             action:@selector(calendarPreButtonClick:)
                                       controlEvent:UIControlEventTouchUpInside];
    [self.view addSubview:_calendarPreButton];
    
    _calendarNextButton = [UIButton buttonWithFrame:CGRectZero
                                               title:nil
                                         normalImage:[UIImage imageNamed:@"scheduleBtnN1.png"] highlightImage:[UIImage imageNamed:@"scheduleBtnH.png"] selectedImage:nil
                                                font:NULL
                                              target:self
                                              action:@selector(calendarNextButtonClick:)
                                        controlEvent:UIControlEventTouchUpInside];
    [self.view addSubview:_calendarNextButton];
    
    [self loadNavigatioBarButtonAddTitle];
}


/**
 *    @brief    加载横竖屏下的日历显示年月的label
 *
 *    @param     isLandscape     是否为横屏
 */
- (void)loadCalendarMonthLabelIfLandscape:(BOOL)isLandscape {
    
    if (isLandscape) {
        [_calendarMonthLabel setFrame:CGRectMake(CALENDARMONTHLABEL_LANDSCAPE_X, CALENDARMONTHLABEL_LANDSCAPE_Y, CALENDARMONTHLABEL_LANDSCAPE_WIDTH, CALENDARMONTHLABEL_LANDSCAPE_HEIGHT)];
    }
    else {
        [_calendarMonthLabel setFrame:CGRectMake(CALENDARMONTHLABEL_PORTAIR_X, CALENDARMONTHLABEL_PORTAIR_Y, CALENDARMONTHLABEL_PORTAIR_WIDTH , CALENDARMONTHLABEL_PORTAITR_HEIGHT)];
    }
    [_calendarMonthLabel setBackgroundColor:[UIColor clearColor]];
    [_calendarMonthLabel setTag:kMonthLabelTeg];
    [_calendarMonthLabel setTextColor:[UIColor colorWithRed:95/255.0 green:78/255.0 blue:64/255.0 alpha:1]];
    [_calendarMonthLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_calendarMonthLabel setTextAlignment:UITextAlignmentCenter];
}


/**
 *    @brief    加载横竖屏下的日历显示年月的label
 *
 *    @param     isLandscape     是否为横屏
 */
- (void)loadCalendarWeekLabelIfLandscape:(BOOL)isLandscape {
    
    NSArray *weekNameArray = [NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    if (isLandscape) {
        for (int i = 0; i < [weekNameArray count]; i++) {
            UILabel *weekLabel = (UILabel *)[self.view viewWithTag:kWeekLabelTag+i+10];
            UILabel *weekLabel1 = (UILabel *)[self.view viewWithTag:kWeekLabelTag+i];
            if (weekLabel1) {
                [weekLabel1 removeFromSuperview];
            }
            if (!weekLabel) {
                weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * CALENDARWEEKLABEL_LANDSCAPE_WIDTH/7+CALENDARWEEKLABEL_LANDSCAPE_X, CALENDARWEEKLABEL_LANDSCAPE_Y, CALENDARWEEKLABEL_LANDSCAPE_WIDTH/7, CALENDARWEEKLABEL_LANDSCAPE_HEIGHT)];
                [weekLabel setTag:(kWeekLabelTag + i+10)];
                [weekLabel setBackgroundColor:kCalendarWeekdayTitleColor];
                [weekLabel setTextAlignment:UITextAlignmentCenter];
                [weekLabel setFont:[UIFont systemFontOfSize:14.0]];
                [weekLabel setTextColor:[UIColor colorWithRed:95/255.0 green:78/255.0 blue:64/255.0 alpha:1.0]];
                [weekLabel setText:[weekNameArray objectAtIndex:i]];
                [self.view addSubview:weekLabel];
                
            }
        }
    }
    else {
        for (int i = 0; i < [weekNameArray count]; i++) {
            UILabel *weekLabel = (UILabel *)[self.view viewWithTag:kWeekLabelTag+i];
            UILabel *weekLabel1 = (UILabel *)[self.view viewWithTag:kWeekLabelTag+i+10];
            if (weekLabel1) {
                [weekLabel1 removeFromSuperview];
            }
            if (!weekLabel) {
                weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * CALENDARWEEKLABEL_PORTAIT_WIDTH/7+CALENDARWEEKLABEL_PORTAIT_X, CALENDARWEEKLABEL_PORTAIT_Y, CALENDARWEEKLABEL_PORTAIT_WIDTH/7, CALENDARWEEKLABEL_PORTAIT_HEIGHT)];
                [weekLabel setTag:(kWeekLabelTag + i)];
                [weekLabel setBackgroundColor:kCalendarWeekdayTitleColor];
                [weekLabel setTextAlignment:UITextAlignmentCenter];
                [weekLabel setFont:[UIFont systemFontOfSize:14.0]];
                [weekLabel setTextColor:[UIColor colorWithRed:95/255.0 green:78/255.0 blue:64/255.0 alpha:1.0]];
                [weekLabel setText:[weekNameArray objectAtIndex:i]];
                [self.view addSubview:weekLabel];
               
            }
        }
        
    }
}


/**
 *    @brief    加载横竖屏下日历的前后项按钮
 *
 *    @param     isLandscape     是否为横屏
 */
- (void)loadCalendarButtonIfLandscape:(BOOL)isLandscape {
    
    if (isLandscape) {
        _calendarPreButton.frame = CGRectMake(CALENDARPREBUTTON_LANDSCAPE_X, CALENDARBUTTON_LANDSCAPE_Y, CALENDARBUTTON_WIDTH, CALENDARBUTTON_HEIGHT);
        _calendarNextButton.frame = CGRectMake(CALENDARNEXTBUTTON_LANDSCAPE_X, CALENDARBUTTON_LANDSCAPE_Y, CALENDARBUTTON_WIDTH, CALENDARBUTTON_HEIGHT);
    }
    else {
        _calendarPreButton.frame = CGRectMake(CALENDARPREBUTTON_PORTRAIT_X, CALENDARBUTTON_PORTRAIT_Y, CALENDARBUTTON_WIDTH, CALENDARBUTTON_HEIGHT);
        _calendarNextButton.frame = CGRectMake(CALENDARNEXTBUTTON_PORTRAIT_X, CALENDARBUTTON_PORTRAIT_Y, CALENDARBUTTON_WIDTH, CALENDARBUTTON_HEIGHT);
    }
}



#pragma mark --------私有方法 --------
/**
 *    @brief    请求会议排期
 */
//- (void)requestSchedules {
//    NSString *url = [NSString stringWithFormat:@"%@%@%@", HTTP, SERVER, GET_SCHEDULE_URL];
//    NSString *scheduleParameter = [NSString stringWithFormat:@"year=%d&month=%d", _selectedYear, _selectedMonth];
//    NSLog(@"%@", scheduleParameter);
//    NetworkHelper *getScheduleNetwork = [[NetworkHelper alloc] init];
//    [getScheduleNetwork setDelegate:self];
//    [getScheduleNetwork setConnectType:SynConnect];
//    [getScheduleNetwork connectUrl:url
//              withNetworkInterface:NetworkInterfaceSchedule
//                        httpMethod:@"POST"
//                         parameter:scheduleParameter];
//}


/**
 *    @brief    更新会议排期
 */
//- (void)updateSchedules {
//    Schedule *schedule = nil;
//    for ( int i = 0; i < [_monthScheduleDatasource count]; i++) {
//        schedule = [_monthScheduleDatasource objectAtIndex:i];
//        [schedule insertToDatabase];
//    }
//}


/**
 *    @brief    通过所选中的日期来改变显示年月的label
 *
 *    @param     selectedDate     所选中的日期
 */
- (void)changeCalendarMonthLabelTitleBySelectedDate:(CFGregorianDate)selectedDate {
    _calendarMonthLabel.text = [NSString stringWithFormat:@"%d年%d月",selectedDate.year,selectedDate.month];
}


/**
 *    @brief    从服务器成功返回请求的某月排程
 *
 *    @param     monthScheduleArray     服务器返回的某月排程
 *    @param     isSeverLogin        是否是服务器登录
 *    @param     isDelete            是否需要是删除操作
 */
//- (void)completeLoadingMonthScheduleArray:(NSArray *)monthScheduleArray isSeverLogin:(BOOL)isSeverLogin isDelete:(BOOL)isDelete {
//    if (_monthScheduleDatasource) {
//        _monthScheduleDatasource = nil;
//    }
//    _monthScheduleDatasource = [[NSMutableArray alloc] init];
//    __block NSMutableArray *tempMarkDateMonthArray = [[NSMutableArray alloc] init];
//    if (monthScheduleArray) {
//        [monthScheduleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            Schedule *schedule = (Schedule *)obj;
//            NSString *startTime = [self formatterDate:[self dateFromString:schedule.startTime] formatterString:@"yyyy-MM"];
//            NSString *endTime = [self formatterDate:[self dateFromString:schedule.endTime] formatterString:@"yyyy-MM"];
//
//            int startDay = 0;
//            int endDay = -1;
//            NSString *curSelectedTime = [self formatterDate:_selectedDate formatterString:@"yyyy-MM"];
//
//            if ([startTime compare:curSelectedTime] == NSOrderedAscending && [endTime compare:curSelectedTime] ==NSOrderedDescending ) {
//                startDay = 1;
//                endDay = 31;
//                [_monthScheduleDatasource addObject:schedule];
//            }
//            else if([startTime compare:curSelectedTime] == NSOrderedSame && [endTime compare:curSelectedTime] ==NSOrderedSame ) {
//
//                startDay = [[self formatterDate:[self dateFromString:schedule.startTime] formatterString:@"d"] intValue];
//                endDay = [[self formatterDate:[self dateFromString:schedule.endTime] formatterString:@"d"] intValue];
//                [_monthScheduleDatasource addObject:schedule];
//            }
//            else if ([startTime compare:curSelectedTime] == NSOrderedAscending && [endTime compare:curSelectedTime] ==NSOrderedSame) {
//                startDay = 1;
//                endDay = [[self formatterDate:[self dateFromString:schedule.endTime] formatterString:@"d"] intValue];
//                [_monthScheduleDatasource addObject:schedule];
//            }
//            else if ([startTime compare:curSelectedTime] == NSOrderedSame && [curSelectedTime compare:endTime] ==NSOrderedAscending) {
//
//                startDay = [[self formatterDate:[self dateFromString:schedule.startTime] formatterString:@"d"] intValue];
//                endDay = 31;
//                [_monthScheduleDatasource addObject:schedule];
//            }
//            for (int i = startDay; i <= endDay; i++) {
//                NSString *dayStr = [NSString stringWithFormat:@"%i",i];
//                if (![tempMarkDateMonthArray containsObject:dayStr]) {
//                    [tempMarkDateMonthArray addObject:dayStr];
//                }
//            }
//        }];
//    }
//
//    _csCalendarView.toMarkDayDataSource = tempMarkDateMonthArray;
//    SAFE_RELEASE(tempMarkDateMonthArray);
//
//    if (isSeverLogin) {
//        if (isDelete) {
//            /*Z_F,2013-02-04,删除本地选中月份的所有数据*/
//            [Schedule deleteMonthSchedulesFromDatabaseWithSelectedYear:_selectedYear SelectedMonth:_selectedMonth];
//            //      for (int i = 0; i < _monthScheduleDatasource.count; i++) {
//            //        [Schedule deleteMonthSchedulesFromDatabaseWithSchedule:[_monthScheduleDatasource objectAtIndex:i]];
//            //      }
//            /*------------------------------------*/
//        }
//        [self updateSchedules];
//    }
//}



/**
 *    @brief    获取指定某天排期的数据
 */
//- (void)getSelectedMarkDayDataSource {
//    int selectedDay = [[self formatterDate:_selectedDate formatterString:@"d"] intValue];
//    __block NSMutableArray *tempScheduleArray = [[NSMutableArray alloc] init];
//    [_monthScheduleDatasource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        Schedule *schedule = (Schedule *)obj;
//        NSString *startTimeStr = [self formatterDate:[self dateFromString:schedule.startTime] formatterString:@"yyyy-MM"];
//        NSString *endTimeStr = [self formatterDate:[self dateFromString:schedule.endTime] formatterString:@"yyyy-MM"];
//        NSString *curSelectedTimeStr = [self formatterDate:_selectedDate formatterString:@"yyyy-MM"];
//        int scheduleStartDay = [[self formatterDate:[self dateFromString:schedule.startTime] formatterString:@"d"] intValue];
//        int scheduleEndDay = [[self formatterDate:[self dateFromString:schedule.endTime] formatterString:@"d"] intValue];
//        if ([startTimeStr compare:curSelectedTimeStr] == NSOrderedAscending && [endTimeStr compare:curSelectedTimeStr] == NSOrderedDescending) {
//            //起止日期不是本月
//            [tempScheduleArray addObject:schedule];
//        }else if ([startTimeStr compare:curSelectedTimeStr] == NSOrderedSame && [endTimeStr compare:curSelectedTimeStr] == NSOrderedSame) {
//            //起止日期是本月
//            if ( selectedDay >=scheduleStartDay && selectedDay <= scheduleEndDay) {
//                [tempScheduleArray addObject:schedule];
//            }else {
//                if (selectedDay == scheduleStartDay) {
//                    [tempScheduleArray addObject:schedule];
//                }else if (selectedDay > scheduleStartDay && selectedDay < scheduleEndDay) {
//                    [tempScheduleArray addObject:schedule];
//                }else if (selectedDay == scheduleEndDay) {
//                    [tempScheduleArray addObject:schedule];
//                }
//            }
//
//        }else if ([startTimeStr compare:curSelectedTimeStr] == NSOrderedAscending && [endTimeStr compare:curSelectedTimeStr] == NSOrderedSame) {
//            //结束日期在本月,开始日期不在
//            if ( selectedDay <= scheduleEndDay) {
//                [tempScheduleArray addObject:schedule];
//            }else if (selectedDay == scheduleEndDay) {
//                [tempScheduleArray addObject:schedule];
//            }else if (selectedDay < scheduleEndDay) {
//                [tempScheduleArray addObject:schedule];
//            }
//        }else if ([startTimeStr compare:curSelectedTimeStr] == NSOrderedSame && [endTimeStr compare:curSelectedTimeStr] == NSOrderedDescending){
//            //开始日期在本月,结束日期不在
//            if ( selectedDay >= scheduleStartDay) {
//                [tempScheduleArray addObject:schedule];
//            }else if (selectedDay == scheduleStartDay) {
//                [tempScheduleArray addObject:schedule];
//            }else if (selectedDay > scheduleStartDay) {
//                [tempScheduleArray addObject:schedule];
//            }
//        }
//    }];
//    _csCalendarView.toSelectedDayDataSource = [NSMutableArray arrayWithArray:[tempScheduleArray sortedArrayUsingComparator:
//                                                                              ^NSComparisonResult(id obj1, id obj2) {
//                                                                                  return [[(Schedule *)obj1 startTime] compare:[(Schedule *)obj2 startTime]];
//                                                                              }]];
//    SAFE_RELEASE(tempScheduleArray);
//}


/**
 *    @brief    日期格式化
 *
 *    @param     dateString     没有格式化的日期字符串
 *
 *    @return    格式化后的日期
 */
- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //    NSDate *destDate = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

/**
 *    @brief    日期格式化成字符串格式
 *
 *    @param     str 转换格式
 *
 *    @return    格式化后的日期字符串
 */
- (NSString *)formatterDate:(NSDate *)date formatterString:(NSString *)Str {
    NSString *afterFormatterStr = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"]];
    [dateFormatter setDateFormat:Str];
    afterFormatterStr = [dateFormatter stringFromDate:date];
   
    return afterFormatterStr;
}


#pragma mark --------按钮事件 --------
/**
 *    @brief    通过日历Pre按钮切换到上个月
 *
 *    @param     sender     Pre按钮
 */
- (void)calendarPreButtonClick:(id)sender {
    [_calendarPreButton setUserInteractionEnabled:NO];
    [_calendarNextButton setUserInteractionEnabled:NO];
    [_csCalendarView movePrevMonthWithSelectedDay:1 prevYearOrMonth:@"month"];
}

/**
 *    @brief    通过日历Next按钮切换到下个月
 *
 *    @param     sender     Next按钮
 */
- (void)calendarNextButtonClick:(id)sender {
    [_calendarPreButton setUserInteractionEnabled:NO];
    [_calendarNextButton setUserInteractionEnabled:NO];
    [_csCalendarView moveNextMonthWithSelectedDay:1 nextYearOrMonth:@"month"];
}

/**
 *    @brief     会议信息按钮，返回到会议信息列表
 *
 *    @param     sender     会议信息按钮
 */
- (void)conferenceInfoBtnClick:(id)sender {
    //会议信息按钮
    [self.navigationController popViewControllerAnimated:YES];
//    MainViewController *tempMainViewController = (MainViewController *)[MainViewController sharedMainViewController];
//    [tempMainViewController popViewControllerIsToRootView:YES];
}

#pragma mark --------系统自带  --------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllCalendarViews];
    [self relayoutForInterfaceOrientation:[Global interfaceOrientation] withDuration:0.3];
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


/**
 *    @brief    按照屏幕翻转方向重新对界面元素布局
 *
 *    @param     interfaceOrientation     屏幕方向
 *    @param     duration     动画持续时间
 */
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration {
    if (_csCalendarView.popoverController.popoverVisible == YES) {
        [_csCalendarView.popoverController dismissPopoverAnimated:NO];
    }
    [super relayoutForInterfaceOrientation:interfaceOrientation withDuration:duration];
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        [self layoutElementsForLandscape];
    }
    else {
        [self layoutElementsForPortrait];
    }
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [self relayoutForInterfaceOrientation:toInterfaceOrientation withDuration:duration];
}


#pragma mark ------------SSCalendarViewDelegate------------

//- (BOOL)selectDateChanged:(CFGregorianDate)selectDate {
//    _selectedYear = selectDate.year;
//    _selectedMonth = selectDate.month;
//    _selectedDay = selectDate.day;
//    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d 00:00:00",_selectedYear, _selectedMonth, _selectedDay];
//    if (_selectedDate) SAFE_RELEASE(_selectedDate);
//    _selectedDate = [self dateFromString:dateStr];
//    [self getSelectedMarkDayDataSource];
//    if (_csCalendarView.toSelectedDayDataSource && [_csCalendarView.toSelectedDayDataSource count] >0) {
//        return YES;
//    }
//    return NO;
//}


- (void)hideProgressView {
    //[Global hideProgressViewForType:none message:@"" afterDelay:TIPSSHOWTIME fromWindow:self.view.window];
}

//- (void)monthChanged:(CFGregorianDate)currentCalendarDate {
//
//    [self changeCalendarMonthLabelTitleBySelectedDate:currentCalendarDate];
//
//    _selectedYear = currentCalendarDate.year;
//    _selectedMonth = currentCalendarDate.month;
//    requestYear = currentCalendarDate.year;
//    requestMonth = currentCalendarDate.month;
//
//    NSArray *tempArray = (NSArray *)[[Schedule arrayFromSqlite] retain];
//    if (tempArray) [self completeLoadingMonthScheduleArray:tempArray isSeverLogin:NO isDelete:NO];
//    if (ServerLogin == [Global loginStatus]) {
//        NSString *tips = [NSString stringWithFormat:@"正在获取%d年%02d月的排期\n请稍等...", currentCalendarDate.year, currentCalendarDate.month];
//        [Global showLoadingProgressViewWithText:tips window:[Global currentWindow]];
//
//        [self performSelector:@selector(requestSchedules) withObject:nil afterDelay:0.1];
//    }
//    SAFE_RELEASE(tempArray);
//}

- (void)changedFrameWhenPreOrNext {
    //[self loadViewIfLandscape:UIInterfaceOrientationIsLandscape(kCurrentOrientation)];
}

- (void)didFinishDrawingCalendarView:(CalendarView *)calendarView {
    [_calendarPreButton setUserInteractionEnabled:YES];
    [_calendarNextButton setUserInteractionEnabled:YES];
}


#pragma mark NetworkHelperDelegate ---------------->
//- (void)networkHelper:(NetworkHelper *)networkHelpler networkDidError:(NSInteger)errorCode {
//    switch (errorCode) {
//        case NetworkRequestBadUrlError:
//        case NetworkRequestTimeoutError:
//        case NetworkDisconnectError:
//        case NetworkLostConnectionError:
//        case NetworkInternetConnectionOfflineError:
//        case NetworkRequestFailedError:
//            [Global hideProgressViewForType:failed message:@"网络连接异常\n更新会议排期失败" afterDelay:TIPSSHOWTIME fromWindow:[Global currentWindow]];
//            break;
//        default:
//            [Global hideProgressViewForType:failed  message:@"服务器繁忙\n更新会议排期失败"  afterDelay:TIPSSHOWTIME fromWindow:[Global currentWindow]];
//            break;
//    }
//
//    SAFE_RELEASE(networkHelpler);
//}

//- (void)networkHelper:(NetworkHelper *)networkHelpler didCompleteObjects:(NSArray *)objectsArray {
//    NSArray *checkedObjects = [Global checkServerReponseData:objectsArray];
//
//    switch (networkHelpler.networkInterface) {
//        case NetworkInterfaceSchedule:
//            [self completeLoadingMonthScheduleArray:checkedObjects isSeverLogin:YES isDelete:YES];
//            [_csCalendarView setNeedsDisplay];
//            break;
//        default:
//            break;
//    }
//
//    [Global hideProgressViewForType:none message:@"" afterDelay:0.1 fromWindow:[Global currentWindow]];
//    SAFE_RELEASE(networkHelpler);
//}

@end
