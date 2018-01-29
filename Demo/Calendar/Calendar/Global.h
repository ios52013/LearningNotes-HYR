//
//  Global.h
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HTTPS             @"https://"     //生产
#define HTTP                HTTPS
#define SERVER @"bmmsz.pingan.com"           //pingan 生产

/**
 *    @brief    获取会议排期表接口地址
 */
#define GET_SCHEDULE_URL                 @"/bmms/rest/arrangedmeeting/getMyArranged"



//内容显示页面的frame，相对于主页面
#define CONTENTVIEW_LANDSCAPE_X                         26.0
#define CONTENTVIEW_Y                                               80.0
#define CONTENTVIEW_LANDSCAPE_WIDTH               979.0
#define CONTENTVIEW_LANDSCAPE_HEIGHT              642.0
#define CONTENTVIEW_PORTRAIT_X                            16.0
#define CONTENTVIEW_PORTRAIT_WIDTH                  742.0
#define CONTENTVIEW_PORTRAIT_HEIGHT                 912.0

#define CONTENT_VIEW_BORDER_SIZE                        10.0//内容显示页面的边框大小
#define CONTENT_VIEW_SHADOW_SIZE                      6.0//内容显示页面的阴影大小


#define kkIsVote @"kkIsVote"     //记录会议议程是否允许表决  0代表不可以  1代表可以


/**
 *    @brief    从字典中根据key值获取字符串
 *
 *    @param     dictionary     提取value的数据源字典对象
 *    @param     key     需要提取的value对应的key
 *
 *    @return    key对应value，如果查找不到该key值，返回nil
 */
#define GetStringValueByKey(dictionary, key)  [[dictionary objectForKey:key] isKindOfClass:[NSNull class]]? nil : [dictionary objectForKey:key]




@interface Global : NSObject


/**
 *    @brief    过滤经过处理的数组格式。如果数组中无自定义对象，返回nil，反之，返回自定义对象数据，并将前面的响应代码过滤
 *
 *    @param     resultArray     后台服务器返回的请求结果的对象数组，该数组的第0和1位置存放的是网络响应是否成功的标记，第2位置存放的是服务器返回对象的总数，从第3位置开始存放网络返回的对象，其排列方式如下：
 格式：     index --->    |        0          |          1          |          2          |          3         | ...
 value --->    |result(BOOL)|    errorCode  |       total       |     object_1   | ...
 *
 *    @return    如果服务器返回的响应中包含了模型对象，则返回模型对象数组，如果只是简单的响应成功失败，则返回nil。
 */
+ (NSArray *)checkServerReponseData:(NSArray *)resultArray;


@end
