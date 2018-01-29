//
//  Global.m
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "Global.h"
#import "MainViewController.h"

@implementation Global


/**
 *    @brief    获取当前设备方向
 *
 *    @return    当前设备方向
 */
+ (UIInterfaceOrientation)interfaceOrientation {
    return [[MainViewController sharedMainViewController] interfaceOrientation];
}

/**
 *    @brief    过滤经过处理的数组格式。如果数组中无自定义对象，返回nil，反之，返回自定义对象数据，并将前面的响应代码过滤
 *
 *    @param     resultArray     后台服务器返回的请求结果的对象数组，该数组的第0和1位置存放的是网络响应是否成功的标记，第2位置存放的是服务器返回对象的总数，从第3位置开始存放网络返回的对象，其排列方式如下：
 格式：     index --->    |        0          |          1          |          2          |          3         | ...
 value --->    |result(BOOL)|    errorCode  |       total       |     object_1    | ...
 *
 *    @return    如果服务器返回的响应中包含了模型对象，则返回模型对象数组，如果只是简单的响应成功失败，则返回nil。
 */
+ (NSArray *)checkServerReponseData:(NSArray *)resultArray {
    
    if ([[resultArray objectAtIndex:0] boolValue]) {
        if ([resultArray count] <= 3)
            return [NSArray array];
        NSRange range = NSMakeRange(3, [resultArray count] - 3);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        return [resultArray objectsAtIndexes:indexSet];
    }
    return nil;
}

@end
