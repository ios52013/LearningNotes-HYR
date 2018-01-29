//
//  AppDelegate.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HomeViewController *_homeViewController;
    UINavigationController *_mainNavigationController;
}
@property (strong, nonatomic) UIWindow *window;



@end

