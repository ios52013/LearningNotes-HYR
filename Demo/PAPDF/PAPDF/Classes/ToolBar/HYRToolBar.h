//
//  HYRToolBar.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define BUTTON_MARGIN             4.0

/**
 *    @brief    自由定制的ToolBar控件。支持设置标题，背景，左右侧的按钮控件，并自动垂直对齐和控件之间按照BUTTON_MARGIN的值进行布局。
 */


@interface HYRToolBar : UIView
/**
 *    @brief 显示标题的label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *    @brief    左侧按钮数组，按照在数组中的位置从左到右排列
 */
@property (nonatomic, strong) NSArray *leftSideButtonArray;

/**
 *    @brief    右侧按钮数组，按照在数组中的位置从右到左排列
 */
@property (nonatomic, strong) NSArray *rightSideButtonArray;


/**
 *    @brief    设置背景图片
 *
 *    @param     image     背景图片
 */
- (void)setBackgroundImage:(UIImage *)image;

/**
 *    @brief    设置左侧按钮数组，按照在数组中的位置从左到右排列
 *
 *    @param     array     将要加载到左侧的按钮数组
 */
- (void)setLeftSideButtonArray:(NSArray *)array;

/**
 *    @brief    设置右侧按钮数组，按照在数组中的位置从右到左排列
 *
 *    @param     array     将要加载到右侧的按钮数组
 */
- (void)setRightSideButtonArray:(NSArray *)array;

/**
 *    @brief    设置标题文字
 *
 *    @param     title     标题文字
 */
- (void)setTitle:(NSString *)title;

@end
