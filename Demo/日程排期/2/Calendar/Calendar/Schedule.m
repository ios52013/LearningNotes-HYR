//
//  Schedule.m
//  PACDMS_ipad
//
//  Created by 王猛 on 12-8-1.
//  Copyright (c) 2012年 zbkc. All rights reserved.
//

#import "Schedule.h"
#import "Global.h"


@implementation Schedule

@synthesize arrangeId = _arrangeId;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize arrangeName = _arrangedName;
@synthesize arrangeAddress =_arrangedAddress;
@synthesize groupName = _groupName;
@synthesize isCanceled = _isCanceled;



- (id)init {
    
    if (self = [super init]) {
        _arrangeId = nil;
        _startTime = nil;
        _endTime = nil;
        _arrangedName = nil;
        _arrangedAddress = nil;
        _groupName = nil;
        _isCanceled = nil;
    }
    return self;
}

/**
 *	@brief	从属性字典中解析属性并返回解析后的Schedule对象
 *
 *	@param 	dictionary 	存放从服务器返回的某条记录的key-value对，key（属性名）value（属性值）
 *
 *	@return	该记录生成的 Schedule 对象
 */
+ (Schedule *)scheduleByDictionary:(NSDictionary *)dictionary {
    
    Schedule *schedule = [[Schedule alloc] init];
    schedule.arrangeId = GetStringValueByKey(dictionary, @"arrangedId");
    schedule.startTime = GetStringValueByKey(dictionary, @"startTime");
    schedule.endTime = GetStringValueByKey(dictionary, @"endTime");
    schedule.arrangeName = GetStringValueByKey(dictionary, @"arrangedName");
    schedule.arrangeAddress = GetStringValueByKey(dictionary, @"arrangedAddress");
    schedule.groupName = GetStringValueByKey(dictionary, @"groupName");
    schedule.isCanceled = GetStringValueByKey(dictionary, @"be_canceled") ;
    return schedule;
}

/**
 *	@brief	从属性数组中解析属性并返回解析后的对象
 *
 *	@param 	properties 	存放从本地数据库中返回的某条记录属性数组
 *
 *	@return	该记录生成的Schedule对象
 */
+ (Schedule *)scheduleFromArray:(NSArray *)properties {
    Schedule *schedule = nil;
    if (properties) {
        schedule = [[Schedule alloc] init];
        schedule.arrangeId = [properties objectAtIndex:0];
        schedule.startTime = [properties objectAtIndex:1];
        schedule.endTime = [properties objectAtIndex:2];
        schedule.arrangeName = [properties objectAtIndex:3];
        schedule.arrangeAddress = [properties objectAtIndex:4];
        schedule.groupName = [properties objectAtIndex:5];
        schedule.isCanceled = [properties objectAtIndex:6];
        if ([[properties objectAtIndex:6] isKindOfClass:[NSNull class]])
            schedule.isCanceled = nil;
        else
            schedule.isCanceled = [properties objectAtIndex:6];
    }
    return schedule;
}

/**
 *	@brief	返回本地数据库中 t_Schedule 表存放的所有对象
 *
 *	@return	Schedule对象数组
 */
+ (NSMutableArray *)arrayFromSqlite {
//    NSString *getScheduleSQL = [NSString stringWithFormat:@"select * from t_Schedule"];
//    NSArray *results = [DataAccessSupport selectData:getScheduleSQL selectColumn:DB_Schedule_Perporities];
//    NSLog(@"results = %@",results);
    NSMutableArray *schedules = [[NSMutableArray alloc] init];
//    Schedule *schedule = nil;
//    if (0 == [results count]) {
//        return  nil;
//    }
//    for (int i = 0;i < [results count]; i++) {
//        NSArray *properties = [results objectAtIndex:i];
//        schedule = [self scheduleFromArray:properties];
//       [schedules addObject:schedule];
//    }
    return schedules;

}

/**
 *	@brief	从本地数据库中删除 t_Schedule 表的所有记录
 *
 *	@return	操作是否成功，成功返回YES，失败返回NO
 */
//+ (BOOL)deleteMonthSchedulesFromDatabaseWithSchedule:(Schedule*)schedule {
//    NSString *deleteAllSQL = [NSString stringWithFormat:@"delete from t_Schedule where arrangeId = \'%@\'",schedule.arrangeId];
//    return [DataAccessSupport dealWithData:deleteAllSQL dealParameter:nil startAtIndex:1];
//}

//+ (BOOL)deleteMonthSchedulesFromDatabaseWithSelectedYear:(int)selectedYear SelectedMonth:(int)selectedMonth {
//    NSString *strSelectedMonth = nil;
//    if (selectedMonth > 9) {
//        strSelectedMonth = [NSString stringWithFormat:@"%d",selectedMonth];
//    }else{
//        strSelectedMonth = [NSString stringWithFormat:@"0%d",selectedMonth];
//    }
//    
//    NSString *startTime = [NSString stringWithFormat:@"%d-%@-00 00:00:00",selectedYear,strSelectedMonth];
//    
//    NSString *endTime = [NSString stringWithFormat:@"%d-%@-32 00:00:00",selectedYear,strSelectedMonth];
//    
//    NSString *deleteSelectedMonthDataSQL = [NSString stringWithFormat:@"delete from t_Schedule where startTime > %@ and endTime < %@",startTime,endTime];
//    return [DataAccessSupport dealWithData:deleteSelectedMonthDataSQL dealParameter:nil startAtIndex:1];
//}

/**
 *	@brief	将对象插入到 t_Schedule表中
 *
 *	@return	操作是否成功，成功返回YES，失败返回NO
 */
//- (BOOL)insertToDatabase {
//    NSLog(@"insertToDatabase");
//    NSMutableArray *properties = [[NSMutableArray alloc] initWithCapacity:DB_Schedule_Perporities];
//    if (!_arrangeId ||!_arrangedName || !_arrangedAddress || !_startTime || ! _endTime) {
//        [properties release];
//        NSLog(@"插入信息失败---数据不能为空");
//        return NO;
//    }
//    [properties addObject:_arrangeId];
//    [properties addObject:_startTime];
//    [properties addObject:_endTime];
//    [properties addObject:_arrangedName];
//    [properties addObject:_arrangedAddress];
//     [properties addObject:_groupName];
//    if (!_isCanceled)[properties addObject:[NSNull null]];
//    else [properties addObject:_isCanceled];
////    [properties addObject:_groupName];
////    [properties addObject:_arrangeId];
//    NSString *insertGroupSQL =@"insert or replace into t_Schedule values(?, ?, ?, ?,?,?,?)";
//    BOOL result = [DataAccessSupport dealWithData:insertGroupSQL dealParameter:properties startAtIndex:1];
//    if (result)
//        NSLog(@"----- 向 t_Schedule 表中插入一条数据 -----");
//    else
//        NSLog(@"----- 向 t_Schedule表中插入数据失败 -----            ++++++++ 失败信息 +++++++");
//    [properties release];
//    return result;
//
//}


@end













