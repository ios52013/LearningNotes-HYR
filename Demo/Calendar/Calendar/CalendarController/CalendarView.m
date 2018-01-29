//
//  CalendarView.m
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/24.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "CalendarView.h"
#import "UIControl+extension.h"
#import "Global.h"

#define kCurrentOrientation      [[UIApplication sharedApplication] statusBarOrientation]


@implementation CalendarView


-(void)initCalView{
    currentTime=CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,tz);
    CFRelease(tz);
    currentMonthDate.day=1;
    currentSelectDate.year=0;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initCalView];
        _selectedDateHasSchedule = NO;
    }
    return self;
}

- (int)getDayCountOfaMonth:(CFGregorianDate)date {
    switch (date.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 2:
            if((date.year%4==0 && date.year%100!=0)||date.year%400 == 0)
                return 29;
            else
                return 28;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        default:
            return 31;
    }
}

- (void)drawGirdLines {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat width = self.frame.size.width;
    int row_Count = ([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
    CGFloat s_width = width / 7.0;
    CGFloat lineHeight;
    if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
        lineHeight = CALENDARVIEW_LANDSCAPE_HEIGHT;
    }
    else
        lineHeight = CALENDARVIEW_PORTAIR_HEIGHT;
    
    CGFloat tabHeight = row_Count * lineHeight;
    for(int i = 0; i < row_Count + 1; i++) {
        CGContextSetRGBStrokeColor(ctx, 184/255.0, 161/255.0, 148/255.0, 1.0f);
        CGContextMoveToPoint(ctx, 0, i * lineHeight);
        CGContextAddLineToPoint(ctx, width, i * lineHeight);
        CGContextStrokePath(ctx);
    }
    for(int i = 1; i < 7; i++) {
        CGContextSetRGBStrokeColor(ctx, 184/255.0,161/255.0, 148/255.0, 1.0f);
        CGContextMoveToPoint(ctx, i * s_width, 0);
        CGContextAddLineToPoint( ctx, i * s_width, tabHeight);
        CGContextStrokePath(ctx);
    }
}

- (void)setToday {//返回今天所在日期包含多少个星期
    CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    currentSelectDate = CFAbsoluteTimeGetGregorianDate(currentTime,tz);
    CFRelease(tz);
    self.numWeeksForSelectedDate =  ([self getDayCountOfaMonth:currentSelectDate]+[self getMonthWeekday:currentSelectDate]-2)/7+1;
}

- (int)getMonthWeekday:(CFGregorianDate)date {
    int returnValue = 0;
    CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    CFGregorianDate month_date;
    month_date.year = date.year;
    month_date.month = date.month;
    month_date.day = 1;
    month_date.hour = 0;
    month_date.minute = 0;
    month_date.second = 1;
    returnValue = (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
    CFRelease(tz);
    return returnValue;
}

- (void)drawDateWords {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat width = self.frame.size.width;
    int dayCount = [self getDayCountOfaMonth:currentMonthDate];
    
    int day = 0;
    int x = 0;
    int y = 0;
    CGFloat s_width = width / 7.0;
    int curr_Weekday = [self getMonthWeekday:currentMonthDate];//每个月的1号是星期几
    
    UIFont *weekfont = [UIFont boldSystemFontOfSize:DayFont];
    
    if (curr_Weekday > 1) {
        //上个月份最后几天对应的星期数
        CFGregorianDate preMonthDate = currentMonthDate;
        if(preMonthDate.month > 1)
            preMonthDate.month -= 1;
        else {
            preMonthDate.month = 12;
            preMonthDate.year -= 1;
        }
        CGContextSetGrayFillColor(ctx, 0.5, 1.0);
        int preMonthDaysCount = [self getDayCountOfaMonth:preMonthDate];
        
        x = curr_Weekday - 2;
        y = 0;
        for (int i = preMonthDaysCount; i > preMonthDaysCount - curr_Weekday - 1; i--) {
            //画背景颜色
            CGRect drawImageRect;
            CGPoint dataPoint;
            if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
                drawImageRect = CGRectMake(x * s_width,
                                           y * CALENDARVIEW_LANDSCAPE_HEIGHT,
                                           s_width,
                                           CALENDARVIEW_LANDSCAPE_HEIGHT);
                dataPoint = CGPointMake(x*s_width + (s_width - DayFont) / 2.0,
                                        y*CALENDARVIEW_LANDSCAPE_HEIGHT + (CALENDARVIEW_LANDSCAPE_HEIGHT - DayFont) / 2.0);
            }
            else {
                drawImageRect = CGRectMake(x * s_width,
                                           y * CALENDARVIEW_PORTAIR_HEIGHT,
                                           s_width,
                                           CALENDARVIEW_PORTAIR_HEIGHT);
                dataPoint = CGPointMake(x*s_width+(s_width - DayFont) / 2.0, y * CALENDARVIEW_PORTAIR_HEIGHT + (CALENDARVIEW_PORTAIR_HEIGHT - DayFont) / 2.0);
            }
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextSetRGBFillColor(ctx, 0.7, 0.7, 0.7, 1);
            UIImage *normalImage = [UIImage imageNamed:@"dayBtn_normal_bg.png"];   //正常的日期背景图片
            
            CGContextDrawImage(ctx, drawImageRect, normalImage.CGImage);
            
            //画日期对应的数字
            NSString *date = [[NSString alloc] initWithFormat:@"%02d",i];
            [date drawAtPoint:dataPoint withFont:weekfont];
            
            x--;
        }
    }
    
    //当前月份天数对应的星期数
    CGContextSetRGBFillColor(ctx, 95/255.0, 78/255.0, 64/255.0, 1);
    for(int i = 1; i < dayCount + 1; i++) {
        day = i + curr_Weekday - 2;
        x = day % 7;
        y = day / 7;
        CGRect drawImageRect;
        CGPoint dataPoint;
//        if(UIInterfaceOrientationIsLandscape([Global  interfaceOrientation])) {
//            drawImageRect = CGRectMake(x * s_width,
//                                       y * CALENDARVIEW_LANDSCAPE_HEIGHT,
//                                       s_width,
//                                       CALENDARVIEW_LANDSCAPE_HEIGHT);
//
//            dataPoint = CGPointMake(x*s_width + (s_width - DayFont) / 2.0,
//                                    y*CALENDARVIEW_LANDSCAPE_HEIGHT + (CALENDARVIEW_LANDSCAPE_HEIGHT - DayFont) / 2.0);
//        }
//        else {
            drawImageRect = CGRectMake(x * s_width,
                                       y * CALENDARVIEW_PORTAIR_HEIGHT,
                                       s_width,
                                       CALENDARVIEW_PORTAIR_HEIGHT);
            dataPoint = CGPointMake(x*s_width+(s_width - DayFont) / 2.0, y * CALENDARVIEW_PORTAIR_HEIGHT + (CALENDARVIEW_PORTAIR_HEIGHT - DayFont) / 2.0);
//        }
        
        //画背景颜色
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIImage *normalImage = [UIImage imageNamed:@"dayBtn_normal_bg.png"];   //正常的日期背景图片
        CGContextDrawImage(ctx, drawImageRect, normalImage.CGImage);
        //画月份对应的数字
        NSString *date = [[NSString alloc] initWithFormat:@"%02d",i];
        [date drawAtPoint:dataPoint withFont:weekfont];
    }
    
    int nextMonthFirstDays = 7 - abs(dayCount%7-(7-curr_Weekday+1));
    if (nextMonthFirstDays > 0) {
        //下一个月份前几天对应的星期数
        CGContextSetGrayFillColor(ctx, 0.5, 1.0);
        int beginNextMonthDay = x+1;
        for (int i = 1; i <= 7 - beginNextMonthDay; i++) {
            x++;
            
            CGRect drawImageRect;
            CGPoint dataPoint;
//            if(UIInterfaceOrientationIsLandscape([Global  interfaceOrientation])) {
//                drawImageRect = CGRectMake(x * s_width,
//                                           y * CALENDARVIEW_LANDSCAPE_HEIGHT,
//                                           s_width,
//                                           CALENDARVIEW_LANDSCAPE_HEIGHT);
//                dataPoint = CGPointMake(x*s_width + (s_width - DayFont) / 2.0,
//                                        y*CALENDARVIEW_LANDSCAPE_HEIGHT + (CALENDARVIEW_LANDSCAPE_HEIGHT - DayFont) / 2.0);
//            }
//            else {
                drawImageRect = CGRectMake(x * s_width,
                                           y * CALENDARVIEW_PORTAIR_HEIGHT,
                                           s_width,
                                           CALENDARVIEW_PORTAIR_HEIGHT);
                dataPoint = CGPointMake(x*s_width + (s_width - DayFont) / 2.0, y * CALENDARVIEW_PORTAIR_HEIGHT + (CALENDARVIEW_PORTAIR_HEIGHT - DayFont) / 2.0);
//            }
            //画背景颜色
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            UIImage *normalImage = [UIImage imageNamed:@"dayBtn_normal_bg.png"];   //正常的日期背景图片
            CGContextDrawImage(ctx, drawImageRect, normalImage.CGImage);
            CGContextSetRGBFillColor(ctx, 0.7, 0.7, 0.7, 1);
            
            //画月份对应的数字
            NSString *date = [[NSString alloc] initWithFormat:@"%02d",i];
            [date drawAtPoint:dataPoint withFont:weekfont];
        }
    }
}

- (void)movePrevNext:(int)isPrev SelectedDay:(int)selectedDay {
    //SAFE_RELEASE(_toMarkDayDataSource);
    istouch = NO;
    int viewHeight = self.frame.size.height;
    int posY;
    if(isPrev == 1) {
        posY = viewHeight + 150;
    }
    else {
        posY = -viewHeight - 150;
    }
    
    UIImage *viewImage;
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    viewImageView = (UIImageView *)[[self superview] viewWithTag:1000];
    if (viewImageView) {
        [viewImageView removeFromSuperview];

        viewImageView = nil;
    }
    if (viewImageView == nil) {
        viewImageView = [[UIImageView alloc] initWithImage:viewImage];
        viewImageView.tag = 1000;
        viewImageView.center = self.center;
        
        [[self superview] addSubview:viewImageView];
    }
    
    viewImageView.hidden = NO;
    viewImageView.transform = CGAffineTransformMakeTranslation(0, 0);
    self.hidden = YES;
    
    currentSelectDate.year = currentMonthDate.year;
    currentSelectDate.month = currentMonthDate.month;
    currentSelectDate.day = 1;
    currentSelectDate.hour = 0;
    currentSelectDate.minute = 0;
    currentSelectDate.second = 1;
    [self setNeedsDisplay];
    if (_delegate && [_delegate respondsToSelector:@selector(selectDateChanged:)])
        [_delegate selectDateChanged:currentSelectDate];
    
    self.transform = CGAffineTransformMakeTranslation(0, posY);
    
    self.hidden = NO;
    [UIView beginAnimations:nil    context:nil];
    [UIView setAnimationDuration:0.3];
    self.transform = CGAffineTransformMakeTranslation(0, 0);
    viewImageView.transform = CGAffineTransformMakeTranslation(0, -posY);
    [UIView commitAnimations];
    
    if (_delegate && [_delegate respondsToSelector:@selector(monthChanged:)])
        [_delegate monthChanged:currentMonthDate];
}

- (void)movePrevMonthWithSelectedDay:(int)seletedDay prevYearOrMonth:(NSString*)prevYearOrMonth {
    if([prevYearOrMonth isEqualToString:@"year"])
        currentMonthDate.year--;
    else {
        if(currentMonthDate.month>1)
            currentMonthDate.month-=1;
        else {
            currentMonthDate.month=12;
            currentMonthDate.year-=1;
        }
    }
    if (seletedDay < 1) {
        int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];//当前月总共有多少天
        seletedDay = monthDayCount + seletedDay;
    }
    
    currentMonthDate.day = seletedDay;
    _isPre = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(changedFrameWhenPreOrNext)])
        [_delegate changedFrameWhenPreOrNext];
}

- (void)moveNextMonthWithSelectedDay:(int)seletedDay nextYearOrMonth:(NSString*)nextYearOrMonth {
    int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];//当前月总共有多少天
    seletedDay = monthDayCount + seletedDay;
    
    if([nextYearOrMonth isEqualToString:@"year"])
        currentMonthDate.year++;
    else {
        if(currentMonthDate.month<12)
            currentMonthDate.month+=1;
        else {
            currentMonthDate.month=1;
            currentMonthDate.year+=1;
        }
    }
    currentMonthDate.day = seletedDay;
    
    _isPre = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(changedFrameWhenPreOrNext)])
        [_delegate changedFrameWhenPreOrNext];
}


- (void)drawToday{
    int x;
    int y;
    int day;
    CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    CFGregorianDate today = CFAbsoluteTimeGetGregorianDate(currentTime, tz);
    CFRelease(tz);
    
    if(today.month == currentMonthDate.month && today.year == currentMonthDate.year) {
        CGFloat width = self.frame.size.width;
        CGFloat swidth = width / 7.0;
        int weekday = [self getMonthWeekday:currentMonthDate];
        day = today.day + weekday - 2;
        x = day % 7;
        y = day / 7;
        
        CGRect drawImageRect;
        CGPoint dataPoint;
        if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
            drawImageRect = CGRectMake(x * swidth,
                                       y * CALENDARVIEW_LANDSCAPE_HEIGHT,
                                       swidth,
                                       CALENDARVIEW_LANDSCAPE_HEIGHT);
            dataPoint = CGPointMake(x*swidth + (swidth - DayFont) / 2.0,
                                    y*CALENDARVIEW_LANDSCAPE_HEIGHT + (CALENDARVIEW_LANDSCAPE_HEIGHT - DayFont) / 2.0);
        }
        else {
            drawImageRect = CGRectMake(x * swidth,
                                       y * CALENDARVIEW_PORTAIR_HEIGHT,
                                       swidth,
                                       CALENDARVIEW_PORTAIR_HEIGHT);
            dataPoint = CGPointMake(x*swidth+(swidth - DayFont) / 2.0, y * CALENDARVIEW_PORTAIR_HEIGHT + (CALENDARVIEW_PORTAIR_HEIGHT - DayFont) / 2.0);
        }
        
        //画背景颜色
        CGContextRef ctx=UIGraphicsGetCurrentContext();
        UIImage *todayImage = [UIImage imageNamed:@"todayBg.png"];   //今天的日期背景图片
        CGContextDrawImage(ctx, drawImageRect, todayImage.CGImage);
        
        //画数字
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
        UIFont *weekfont = [UIFont boldSystemFontOfSize:DayFont];
        NSString *date = [[NSString alloc] initWithFormat:@"%02d",today.day];
        [date drawAtPoint:dataPoint withFont:weekfont];
    }
}

//- (void)loadPopViewfromRect:(CGRect)rect {
//    if ([_toMarkDayDataSource containsObject:[NSString stringWithFormat:@"%d",currentSelectDate.day]]) {
//        SchedulingDetailsController *controller = [[SchedulingDetailsController alloc] initWithStyle:UITableViewStylePlain];
//        controller.contentSizeForViewInPopover = CGSizeMake(400, 115);
//        if (controller.scheduleDataSource) {
//            [controller.scheduleDataSource removeAllObjects];
//        }
//        controller.scheduleDataSource = _toSelectedDayDataSource;
//        _popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
//        _popoverController.delegate = self;
//        [_popoverController presentPopoverFromRect:rect inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        [controller release];
//    }
//}

- (void)drawCurrentSelectDate {
    int x;
    int y;
    int day;
    if(currentSelectDate.year != 0)    {
        
        CFTimeZoneRef tz = CFTimeZoneCopyDefault();
        CFRelease(tz);
        
        CGFloat width = self.frame.size.width;
        CGFloat swidth = width / 7.0;
        int weekday = [self getMonthWeekday:currentMonthDate];
        day = currentSelectDate.day + weekday - 2;
        x = day % 7;
        y = day / 7;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect drawImageRect;
        CGPoint dataPoint;
        
        if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
            drawImageRect = CGRectMake(x * swidth,
                                       y * CALENDARVIEW_LANDSCAPE_HEIGHT,
                                       swidth,
                                       CALENDARVIEW_LANDSCAPE_HEIGHT);
            dataPoint = CGPointMake(x*swidth + (swidth - DayFont) / 2.0,
                                    y*CALENDARVIEW_LANDSCAPE_HEIGHT + (CALENDARVIEW_LANDSCAPE_HEIGHT - DayFont) / 2.0);
        }
        else {
            drawImageRect = CGRectMake(x * swidth,
                                       y * CALENDARVIEW_PORTAIR_HEIGHT,
                                       swidth,
                                       CALENDARVIEW_PORTAIR_HEIGHT);
            dataPoint = CGPointMake(x*swidth+(swidth - DayFont) / 2.0, y * CALENDARVIEW_PORTAIR_HEIGHT + (CALENDARVIEW_PORTAIR_HEIGHT - DayFont) / 2.0);
            
        }
        popRect = drawImageRect;
        
        if (istouch) {
            //[self loadPopViewfromRect:popRect];
            
            UIImage *todayImage = nil;
            
            //被选定日期的背景图片
            //      if (!_selectedDateHasSchedule &&  UIInterfaceOrientationIsLandscape([Global interfaceOrientation])) {
            //        todayImage = [UIImage imageForName:@"dayBtn_selectedWithMark_landscape_bg" type:@"png"];
            //      }
            //      else if (!_selectedDateHasSchedule &&  UIInterfaceOrientationIsPortrait([Global interfaceOrientation])) {
            //        todayImage = [UIImage imageForName:@"dayBtn_selectedWithMark_portrait_bg" type:@"png"];
            //      }
            //      else {
            todayImage = [UIImage imageForName:@"dayBtn_selected_bg" type:@"png"];
            UIView *iconImageView = [self viewWithTag:currentSelectDate.day];
            if (iconImageView) {
                [(UIImageView *)iconImageView setImage:[UIImage imageForName:@"icon_selectedDayMark" type:@"png"]];
            }
            //      }
            CGContextDrawImage(ctx, drawImageRect, todayImage.CGImage);
            CGContextSetRGBFillColor(ctx, 0.3, 0.3, 0.3, 0.5);//设置字体的颜色为白色
            
            UIFont *weekfont = [UIFont boldSystemFontOfSize:DayFont];
            NSString *date = [[NSString alloc] initWithFormat:@"%02d",currentSelectDate.day];
            [date drawAtPoint:dataPoint withFont:weekfont];
        }
    }
}

- (void)touchAtDate:(CGPoint)touchPoint {
    
    int x;
    int y;
    int width = self.frame.size.width;
    int weekday = [self getMonthWeekday:currentMonthDate];//当前月的第一天是星期几
    int monthDayCount = [self getDayCountOfaMonth:currentMonthDate];//当前月总共有多少天
    x = touchPoint.x * 7 / width;//获取当前选择的是第几列
    CGFloat wordHeight;
    if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
        wordHeight = CALENDARVIEW_LANDSCAPE_HEIGHT;
    }
    else {
        wordHeight = CALENDARVIEW_PORTAIR_HEIGHT;
    }
    
    y = touchPoint.y / wordHeight;//获取当前选择的是第几行
    int monthday = x + y * 7 - weekday + 2;//获取当前选择的是哪一日
    if(monthday > 0 && monthday<monthDayCount + 1)
    {//选中当前月份的天数
        currentSelectDate.year = currentMonthDate.year;
        currentSelectDate.month = currentMonthDate.month;
        currentSelectDate.day = monthday;
        currentSelectDate.hour = 0;
        currentSelectDate.minute = 0;
        currentSelectDate.second = 1;
        if (_delegate && [_delegate respondsToSelector:@selector(selectDateChanged:)])
            _selectedDateHasSchedule = [_delegate selectDateChanged:currentSelectDate];
        
        [self setNeedsDisplay];
    }
    else if(monthday <= 0) {//选中上个月份的天数
        [self movePrevMonthWithSelectedDay:monthday prevYearOrMonth:@"month"];
    }
    else {//选中下个月份的天数
        [self moveNextMonthWithSelectedDay:monthday - monthDayCount nextYearOrMonth:@"month"];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    istouch = NO;
    UITouch* touch = [touches anyObject];
    _touchBeginPoint = [touch locationInView:self];
    if (_popoverController.popoverVisible == YES) {
        [_popoverController dismissPopoverAnimated:NO];
//        [_popoverController release];
        _popoverController = nil;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _isTouchMove = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    istouch = YES;
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (_isTouchMove) {
        _isTouchMove = NO;
        if ((touchPoint.y - _touchBeginPoint.y) < -30) {
            [self movePrevMonthWithSelectedDay:1 prevYearOrMonth:@"month"];
        }
        else if ((touchPoint.y - _touchBeginPoint.y) > 30){
            [self moveNextMonthWithSelectedDay:1 nextYearOrMonth:@"month"];
        }
    }
    else{
        [self touchAtDate:touchPoint];
    }
}

- (void)drawRect:(CGRect)rect{
    static int once = 0;
    currentTime = CFAbsoluteTimeGetCurrent();
    
    if(once == 0) {
        once = 1;
        if (_delegate && [_delegate respondsToSelector:@selector(monthChanged:)])
            [_delegate monthChanged:currentMonthDate];
    }
    [self drawDateWords];
    [self drawToday];
    
    [self drawGirdLines];
    [self drawMarkByArray:_toMarkDayDataSource];
    [self drawCurrentSelectDate];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishDrawingCalendarView:)])
        [_delegate didFinishDrawingCalendarView:self];
}

- (void)drawMarkByArray:(NSMutableArray *)array {
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGFloat width = self.frame.size.width;
    int dayCount = [self getDayCountOfaMonth:currentMonthDate];
    int day = 0;
    int x = 0;
    int y = 0;
    CGFloat s_width = width / 7.0;
    int curr_Weekday = [self getMonthWeekday:currentMonthDate];//每个月的1号是星期几
    
    //当前月份天数对应的星期数
    CGContextSetRGBFillColor(ctx, 1.0, 0.0, 0.0, 1);
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    for(int i = 1; i < dayCount + 1; i++) {
        day = i + curr_Weekday - 2;
        x = day % 7;
        y = day / 7;
        if ([array containsObject:[NSString stringWithFormat:@"%i",i]]) {
            //画日程标记
            CGRect rect;
            if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
                rect = CGRectMake(x * s_width + (s_width - 5.0 - CALENDARVIEW_MARKICON_WIDTH) ,
                                  y * CALENDARVIEW_LANDSCAPE_HEIGHT + (CALENDARVIEW_LANDSCAPE_HEIGHT - 5.0 - CALENDARVIEW_MARKICON_HEIGHT),
                                  CALENDARVIEW_MARKICON_WIDTH,
                                  CALENDARVIEW_MARKICON_HEIGHT);
            }
            else {
                rect = CGRectMake(x*s_width + (s_width - 5.0 - CALENDARVIEW_MARKICON_WIDTH),
                                  y*CALENDARVIEW_PORTAIR_HEIGHT +  (CALENDARVIEW_PORTAIR_HEIGHT - 5.0 - CALENDARVIEW_MARKICON_HEIGHT),
                                  CALENDARVIEW_MARKICON_WIDTH,
                                  CALENDARVIEW_MARKICON_HEIGHT);
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            [imageView setTag:i];
            imageView.image = [UIImage imageNamed:@"scheduleMark.png"];
            [self addSubview:imageView];
        }
    }
}


@end
