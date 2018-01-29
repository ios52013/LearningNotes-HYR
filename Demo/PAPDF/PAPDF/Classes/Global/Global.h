//
//  Global.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define PAGESIZE     15.0
#define TITLE_BAR_HEIGHT                                            70.0//导航条高度

#define kCurrentOrientation      [[UIApplication sharedApplication] statusBarOrientation]


//主页面
#define MAINSCREEN_X                                                    0.0
#define MAINSCREEN_Y                                                    0.0
#define MAINSCREEN_LANDSCAPE_WIDTH                    1024.0
#define MAINSCREEN_LANDSCAPE_HEIGHT                   748.0
#define MAINSCREEN_PORTRAIT_WIDTH                      768.0
#define MAINSCREEN_PORTRAIT_HEIGHT                     1004.0



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


//内容显示页面tableview得frame，相对内容显示页面
#define CONTENTTABLEVIEW_X                                     10.0
#define CONTENTTABLEVIEW_Y                                     10.0
#define CONTENTTABLEVIEW_LANDSCAPE_WIDTH      953.0
#define CONTENTTABLEVIEW_LANDSCAPE_HEIGHT     615.0
#define CONTENTTABLEVIEW_PORTRAIT_WIDTH         717.0
#define CONTENTTABLEVIEW_PORTRAIT_HEIGHT        885.0


/**
 *    @brief    标题和内容颜色
 */
#define TITLE_AND_CONTENT_TEXTCOLOR             [UIColor colorWithRed:128.0/255.0 green:64.0/255.0 blue:0 alpha:1]

/**
 *    @brief    小标题颜色
 */
#define SUBTITLE_TEXTCOLOR                                  [UIColor colorWithRed:204.0/255.0 green:85.0/255.0 blue:0 alpha:1]


/**
 *    @brief    配置粗体文字尺寸
 *
 *    @param     font     文字尺寸
 *
 *    @return    加粗UIFont 对象
 */
#define BOLDSYSTEMFONT(font)       [UIFont boldSystemFontOfSize:font]


/**
 *    @brief    配置普通文字尺寸
 *
 *    @param     font     文字尺寸
 *
 *    @return    普通UIFont对象
 */
#define SYSTEMFONT(font)                [UIFont systemFontOfSize:font]




/**
 *    @brief    登录验证的方式
 */
typedef enum {
    LocalLogin = 0, /**< 离线登录 */
    ServerLogin /**< 在线登录 */
}LoginStatus;








@interface Global : NSObject
/**
 *    @brief    获取当前设备方向
 *
 *    @return    当前设备方向
 */
+ (UIInterfaceOrientation)interfaceOrientation;

/**
 *    @brief     获取登录方式
 *
 *    @return    返回当前的登录方式（离线登录或者在线登录）
 */
+ (LoginStatus)loginStatus;


@end
