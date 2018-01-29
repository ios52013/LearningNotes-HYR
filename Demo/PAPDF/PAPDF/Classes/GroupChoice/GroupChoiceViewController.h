//
//  GroupChoiceViewController.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "ContentViewController.h"
#import "Group.h"

//cell 按钮的位置
#define CELLBUTTON_L_X             129.0
#define CELLBUTTON_P_X             11.0
#define CELLBUTTON_Y               25.0

// cell 按钮的大小
#define CELLBUTTON_WIDTH           695.0
#define CELLBUTTON_HEIGHT          85.0

// 自定义cell的高度
#define CELL1_HEIGHT          110

// 指定的cell的高度
#define CELL2_HEIGHT          135


@class GroupChoiceViewController;
@protocol  GroupChoiceViewControllerDelegate <NSObject>
@optional
/**
 *    @brief    在选择了一个group选项以后执行的代理方法
 *
 *    @param     viewController    当前弹出的groupChoiceViewController对象。
 *
 *      @param     group    选择的group对象。
 */
- (void)groupChoiceViewController:(GroupChoiceViewController *)viewController didSelectGroup:(Group *)group;

@end


@interface GroupChoiceViewController : ContentViewController
{
    BOOL _isInitialSystem;
    NSMutableArray *_groupsArray;
}

@property (nonatomic, assign) id delegate;
/**
 *    @brief    通过选项 isInitialSystem 初始化 对象。
 *
 *    @param     isInitialSystem    是否是初始化系统时请求初始化对象，如果为YES，返回不带取消按钮的对象，如果为NO，则提供取消按钮。
 */
- (id)initWithEnvironment:(BOOL)isInitialSystem;


@end
