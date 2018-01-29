//
//  Global.h
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


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



@interface Global : NSObject

/**
 *    @brief    获取当前设备方向
 *
 *    @return    当前设备方向
 */
+ (UIInterfaceOrientation)interfaceOrientation;


@end
