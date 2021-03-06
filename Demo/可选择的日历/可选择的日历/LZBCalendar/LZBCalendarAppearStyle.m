//
//  LZBCalendarAppearStyle.m
//  LZBCalendar
//
//  Created by zibin on 16/11/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBCalendarAppearStyle.h"

@implementation LZBCalendarAppearStyle
- (instancetype)init
{
  if(self = [super init])
  {
      self.isNeedCustomHeihgt = YES;
      self.today = [NSDate date];
      
      self.headerViewDateHeight = 100;
      self.headerViewLineHeight = 1.0;
      self.headerViewWeekHeight = 60;
      self.weekDateDays = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
      self.headerViewDateFont = [UIFont systemFontOfSize:30.0];
      self.headerViewWeekFont = [UIFont systemFontOfSize:14.0];
      self.headerViewWeekColor = [UIColor grayColor];
      self.headerViewDateColor = [UIColor whiteColor];
      
      self.itemHeight = 0;
      self.dateTittleFont = [UIFont systemFontOfSize:16.0];
      self.dateDescFont = [UIFont systemFontOfSize:16.0];
      self.dateTittleSelectColor = [UIColor redColor];
      self.dateTittleUnselectColor = [UIColor blackColor];
      self.dateDescSelectColor = [UIColor blueColor];
      self.dateDescUnselectColor = [UIColor purpleColor];
      self.dateBackUnselectColor = [UIColor whiteColor];
      self.dateBackSelectColor = [UIColor orangeColor];
      self.isSupportMoreSelect = NO;
      self.dateTitleDescOffset = UIOffsetMake(0, 10);
      
  }
    return self;
}

- (CGFloat)headerViewHeihgt
{
    return self.headerViewDateHeight + self.headerViewLineHeight + self.headerViewWeekHeight;
}



@end
