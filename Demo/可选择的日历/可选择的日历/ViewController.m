//
//  ViewController.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBCalendar.h"
#import "LZBCalendarAppearStyle.h"
#import "NSDate+Component.h"

@interface ViewController ()<LZBCalendarDataSource,LZBCalendarDataDelegate>

@property (nonatomic, strong) LZBCalendar *calendar;
@property (nonatomic, strong)  LZBCalendarAppearStyle *style;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImage];
    
    [self.view addSubview:self.calendar];
    
}
#pragma mark - 20180126晚修改
#pragma mark - 设置背景图
- (void)setBackgroundImage {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    //bgImageView.image = [UIImage imageForName:@"bg-nav" type:@"png"];
    bgImageView.image = [UIImage imageNamed:@"bg-nav"];
    bgImageView.alpha = 0.6;
    [self.view addSubview:bgImageView];
}


#pragma mark - 屏幕翻转就会调用
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.calendar.frame = CGRectMake(40, 60, [UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height);
}



#pragma mark - delegate
- (void)calendar:(LZBCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"当前调用的方法:%s------行号:line-%d ",__func__, __LINE__);
    
}


#pragma mark - dataSoure
- (NSString *)calendar:(LZBCalendar *)calendar titleForDate:(NSDate *)date
{
    if([[NSDate date] getDateWithMonth] == [date getDateWithMonth])
    {
        NSInteger result =[[NSDate date] getDateWithDay] -[date getDateWithDay];
        switch (result) {
            case 0:
                return @"今天";
                break;
            case 1:
                return @"昨天";
                break;
            case -1:
                 return @"明天";
                break;
                
            default:
                return nil;
                break;
        }
    }
    else
        return nil;
}

- (NSString *)calendar:(LZBCalendar *)calendar subtitleForDate:(NSDate *)date
{
    NSInteger result = [date getDateWithDay];
    switch (result) {
        case 1:
            return @"10";
            break;
        case 2:
            return @"20";
            break;
        case 3:
            return @"免费";
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)calendar:(LZBCalendar *)calendar layoutCallBackHeight:(CGFloat)height
{
    //self.calendar.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, height);
}


#pragma mark - lazy
- (LZBCalendar *)calendar
{
  if(_calendar == nil)
  {
      _calendar = [[LZBCalendar alloc]initWithStyle:self.style];
      _calendar.dataSource = self;
      _calendar.delegate = self;
  }
    return _calendar;
}

- (LZBCalendarAppearStyle *)style
{
  if(_style == nil)
  {
      _style = [[LZBCalendarAppearStyle alloc]init];
      _style.isNeedCustomHeihgt = YES;
      
  }
    return _style;
}


@end
