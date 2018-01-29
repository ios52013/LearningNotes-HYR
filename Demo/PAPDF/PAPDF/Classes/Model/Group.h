//
//  Group.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *    @brief    组织机构模型类，保存组织机构的一些基本信息
 */

@interface Group : NSObject {
    NSString *_gid;                             //机构编号
    NSString *_groupName;                       //机构名称
    NSString *_groupCode;                       //机构代码
}

/**
 *    @brief    唯一标示组织机构对象的字符串
 */
@property (nonatomic, copy) NSString *gid;

/**
 *    @brief    标示组织机构的名称
 */
@property (nonatomic, copy) NSString *groupName;

/**
 *    @brief    标示组织机构的机构代码
 */
@property (nonatomic, copy) NSString *groupCode;



/**
 *    @brief    返回本地数据库中 t_Group 表存放的所有对象
 *
 *    @return    Group对象数组
 */
+ (NSMutableArray *)arrayFromSqlite;

@end
