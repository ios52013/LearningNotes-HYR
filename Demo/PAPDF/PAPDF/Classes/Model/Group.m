//
//  Group.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "Group.h"

@implementation Group
/**
 *    @brief    返回本地数据库中 t_Group 表存放的所有对象
 *
 *    @return    Group 对象数组
 */
+ (NSMutableArray *)arrayFromSqlite {
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
  
    Group *group1 = [[self alloc] init];
    group1.groupName = @"平安科技(PINGAN)";
    [groups addObject:group1];
    
    Group *group2 = [[self alloc] init];
    group2.groupName = @"集团总部test";
    [groups addObject:group2];
    
    return groups;
}

@end
