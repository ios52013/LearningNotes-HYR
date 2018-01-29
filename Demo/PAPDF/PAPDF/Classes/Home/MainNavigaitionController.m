//
//  MainNavigaitionController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "MainNavigaitionController.h"
#import "Global.h"

@interface MainNavigaitionController ()

@end

@implementation MainNavigaitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//屏幕旋转

- (BOOL)shouldAutorotate{
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)] ) {
        return [self.topViewController shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [Global interfaceOrientation];
    
}

@end
