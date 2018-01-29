//
//  CommonViewController.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//
//    最顶层类，只包含一个导航条

#import <UIKit/UIKit.h>
#import "HYRToolBar.h"

#define NAVBAR_TITLE_L_X                        310.0
#define NAVBAR_TITLE_P_X                        200.0
#define NAVBAR_TITLE_Y                            0.0
#define NAVBAR_TITLE_WIDTH                  405.0
#define NAVBAR_TITLE_HEIGHT                 65.0

/**
 *    @brief    父类控制器，只包含一个功能导航条，有需要用到导航条的子控制器会继承此类，本类提供了一个HYRToolBar作为导航控件以及定制的界面背景，并且提供了横竖屏转换的基础实现接口
 */

@interface CommonViewController : UIViewController
/**
 *    @brief    位于界面的上方，提供导航功能的定制toolbar
 */
@property(nonatomic,readonly,strong)HYRToolBar *navigationBar;


/**
 *    @brief    横竖屏切换时重先布局界面元素
 *
 *    @param     interfaceOrientation     当前屏幕方向
 *    @param     duration     横竖屏切换的动画时间
 */
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration;

@end
