//
//  Schedule.h
//  PACDMS_ipad
//
//  Created by 王猛 on 12-8-1.
//  Copyright (c) 2012年 zbkc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *	@brief	本地数据库 t_Schedule 表中保存的字段数
 */
#define DB_Schedule_Perporities   7


/**
 *	@brief	会议排期模型类，保存会议排期的一些基本信息，例如：会议排期id，开始时间，结束时间，会议名称，会议地点等
 */
@interface Schedule : NSObject {
    NSString *_arrangeId;        //会议排期id
    NSString *_startTime;          //会议开始时间
    NSString *_endTime;            //会议结束时间
    NSString *_arrangedName;      //会议名称
    NSString *_arrangedAddress;    //会议地点
    NSString *_groupName;          //所属公司名称
    NSString *_isCanceled ;            //是否有效
}

/**
 *	@brief	会议排期id
 */
@property (nonatomic,copy) NSString *arrangeId;

/**
 *	@brief	会议开始时间
 */
@property (nonatomic,copy) NSString *startTime;

/**
 *	@brief	会议结束时间
 */
@property (nonatomic,copy) NSString *endTime;

/**
 *	@brief	会议名称
 */
@property (nonatomic,copy) NSString *arrangeName;

/**
 *	@brief	会议地点
 */
@property (nonatomic,copy) NSString *arrangeAddress;

/**
 *	@brief	所属公司名称
 */
@property (nonatomic,copy) NSString *groupName;

/**
 *	@brief	是否有效，0表示纪录已被删除
 */
@property (nonatomic,copy) NSString *isCanceled;

/**
 *	@brief	从属性字典中解析属性并返回解析后的Schedule对象
 *
 *	@param 	dictionary 	存放从服务器返回的某条记录的key-value对，key（属性名）value（属性值）
 *
 *	@return	该记录生成的 Schedule 对象
 */
+ (Schedule *)scheduleByDictionary:(NSDictionary *)dictionary;

/**
 *	@brief	从属性数组中解析属性并返回解析后的对象
 *
 *	@param 	properties 	存放从本地数据库中返回的某条记录属性数组
 *
 *	@return	该记录生成的Schedule对象
 */
+ (Schedule*)scheduleFromArray:(NSArray *)properties;
/**
 *	@brief	返回本地数据库中 t_Schedule 表存放的所有对象
 *
 *	@return	Schedule对象数组
 */
+ (NSMutableArray *)arrayFromSqlite;

/**
 *	@brief	从本地数据库中删除 t_Schedule 表的所有记录
 *
 *	@return	操作是否成功，成功返回YES，失败返回NO
 */
+ (BOOL)deleteMonthSchedulesFromDatabaseWithSchedule:(Schedule*)schedule;

/**
 *	@brief	从本地数据库中删除 t_Schedule 表中选中月份的所有记录
 *
 *	@return	操作是否成功，成功返回YES，失败返回NO
 */
+ (BOOL)deleteMonthSchedulesFromDatabaseWithSelectedYear:(int)selectedYear SelectedMonth:(int)selectedMonth;

/**
 *	@brief	将对象插入到 t_Schedule表中
 *
 *	@return	操作是否成功，成功返回YES，失败返回NO
 */
- (BOOL)insertToDatabase;

@end














