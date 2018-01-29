//
//  ContentViewController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "ContentViewController.h"
#import "Global.h"
#import "UIViewExt.h"
#import "UIControl+extension.h"


@interface ContentViewController ()

@end

@implementation ContentViewController



- (UITableView *)contentTableView {
    return _dragRefreshViewController.contentTableView;
}

- (UILabel *)leftTitleLabel {
    return _dragRefreshViewController.leftTitleLabel;
}

- (UILabel *)middleTitleLabel {
    return _dragRefreshViewController.middleTitleLabel;
}

- (UILabel *)rightTitleLabel {
    return _dragRefreshViewController.rightTitleLabel;
}

- (UIView *)contentTitleView {
    return _dragRefreshViewController.contentTitleView;
}

- (UIImageView *)contentTitleViewBackgroundView {
    return _dragRefreshViewController.contentTitleViewBackgroundView;
}

- (RefreshDirection)refreshDirection {
    return _dragRefreshViewController.refreshDirection;
}

- (BOOL)isNeedPushDownRefresh {
    return _dragRefreshViewController.isNeedPushDownRefresh;
}

- (BOOL)isNeedPushUpRefresh {
    return _dragRefreshViewController.isNeedPushUpRefresh;
}



- (BOOL)isLoading {
    return _dragRefreshViewController.isLoading;
}

- (void)setIsNeedPushDownRefresh:(BOOL)isNeedPushDownRefresh {
    _dragRefreshViewController.isNeedPushDownRefresh = isNeedPushDownRefresh;
}
- (void)setIsNeedSearch:(BOOL)isNeedSearch {
    _dragRefreshViewController.isNeedSearch = isNeedSearch;
}
- (void)setIsNeedPushUpRefresh:(BOOL)isNeedPushUpRefresh {
    _dragRefreshViewController.isNeedPushUpRefresh = isNeedPushUpRefresh;
}

- (void)setTextPullToDown:(NSString *)textPullToDown {
    [_dragRefreshViewController setTextPullToDown:textPullToDown];
}

- (void)setTextPullToUp:(NSString *)textPullToUp {
    [_dragRefreshViewController setTextPullToUp:textPullToUp];
}

- (void)setTextRelease:(NSString *)textRelease {
    [_dragRefreshViewController setTextRelease:textRelease];
}

- (void)setTextLoading:(NSString *)textLoading {
    [_dragRefreshViewController setTextLoading:textLoading];
}

- (void)startLoading {
    [_dragRefreshViewController startLoading];
}

- (void)stopLoading {
    [_dragRefreshViewController stopLoading];
}



/**
 *    @brief    加载内容显示页面
 */
- (void)loadContentView {
    CGFloat contentViewX = 0.0;
    CGFloat contentViewWidth = 0.0;
    CGFloat contentViewHeight = 0.0;
    if (UIInterfaceOrientationIsLandscape([Global interfaceOrientation])) {
        contentViewX = CONTENTVIEW_LANDSCAPE_X;
        contentViewWidth = CONTENTVIEW_LANDSCAPE_WIDTH;
        contentViewHeight = CONTENTVIEW_LANDSCAPE_HEIGHT;
    }
    else {
        contentViewX = CONTENTVIEW_PORTRAIT_X;
        contentViewWidth = CONTENTVIEW_PORTRAIT_WIDTH;
        contentViewHeight = CONTENTVIEW_PORTRAIT_HEIGHT;
    }
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(contentViewX,
                                                            CONTENTVIEW_Y,
                                                            contentViewWidth,
                                                            contentViewHeight)];
    [_contentView setBackgroundColor:[UIColor clearColor]];
    _contentViewBackgroundView = [[UIImageView alloc] initWithFrame:_contentView.bounds];
    [_contentViewBackgroundView setImage:[UIImage imageForName:@"content_portrait_bg" type:@"png"]];
    [_contentView addSubview:_contentViewBackgroundView];
    [self.view addSubview:_contentView];
}


- (void)loadDragRefreshViewController {
    _dragRefreshViewController = [[DragRefreshViewController alloc] init];
    
    CGFloat contentTableViewWidth = 0.0;
    CGFloat contentTableViewHeight = 0.0;
    if (UIInterfaceOrientationIsLandscape([Global interfaceOrientation])) {
        contentTableViewWidth = CONTENTTABLEVIEW_LANDSCAPE_WIDTH;
        contentTableViewHeight = CONTENTTABLEVIEW_LANDSCAPE_HEIGHT;
    }
    else {
        contentTableViewWidth = CONTENTTABLEVIEW_PORTRAIT_WIDTH;
        contentTableViewHeight = CONTENTTABLEVIEW_PORTRAIT_HEIGHT;
    }
    
    [_dragRefreshViewController.view setFrame:CGRectMake(CONTENTTABLEVIEW_X,
                                                         CONTENTTABLEVIEW_Y,
                                                         contentTableViewWidth,
                                                         contentTableViewHeight)];
    [_dragRefreshViewController.view setBackgroundColor:[UIColor clearColor]];
    [_dragRefreshViewController setDelegate:self];
    [_dragRefreshViewController setSearchDelegate:self];
    [_contentView addSubview:_dragRefreshViewController.view];
}
 



/**
 *    @brief    设置内容标题栏标题
 *
 *    @param     leftTitle     左标题
 *    @param     middleTitle     中间标题
 *    @param     rightTitle     右标题
 */
- (void)setContentTitleWithLeft:(NSString *)leftTitle middle:(NSString *)middleTitle right:(NSString *)rightTitle {
    [_dragRefreshViewController setContentTitleWithLeft:leftTitle middle:middleTitle right:rightTitle];
}





/*-------------------------------------*/

#pragma mark ----     私有接口      ----

/**
 *    @brief    横屏布局
 */
- (void)relayoutElementsForLandscapeInContentView{
    //  [self.view setFrame:CGRectMake(0.0,0.0,MAINSCREEN_LANDSCAPE_WIDTH, MAINSCREEN_LANDSCAPE_HEIGHT)];
    [_contentView setFrame:CGRectMake(CONTENTVIEW_LANDSCAPE_X,
                                      CONTENTVIEW_Y,
                                      CONTENTVIEW_LANDSCAPE_WIDTH,
                                      CONTENTVIEW_LANDSCAPE_HEIGHT)];
    [_dragRefreshViewController.view setFrame:CGRectMake(CONTENTTABLEVIEW_X,
                                                         CONTENTTABLEVIEW_Y,
                                                         CONTENTTABLEVIEW_LANDSCAPE_WIDTH,
                                                         CONTENTTABLEVIEW_LANDSCAPE_HEIGHT)];
    [_contentViewBackgroundView setImage:[UIImage imageForName:@"content_landscape_bg" type:@"png"]];
#pragma mark - add by lc
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _contentView.top += 20;
    }
    
}


/**
 *    @brief    竖屏布局
 */
- (void)relayoutElementsForPortraitInContentView{
    //  [self.view setFrame:CGRectMake(0.0,0.0, MAINSCREEN_PORTRAIT_WIDTH,MAINSCREEN_PORTRAIT_HEIGHT)];
    [_contentView setFrame:CGRectMake(CONTENTVIEW_PORTRAIT_X,
                                      CONTENTVIEW_Y,
                                      CONTENTVIEW_PORTRAIT_WIDTH,
                                      CONTENTVIEW_PORTRAIT_HEIGHT)];
    [_dragRefreshViewController.view setFrame:CGRectMake(CONTENTTABLEVIEW_X,
                                                         CONTENTTABLEVIEW_Y,
                                                         CONTENTTABLEVIEW_PORTRAIT_WIDTH,
                                                         CONTENTTABLEVIEW_PORTRAIT_HEIGHT)];
    [_contentViewBackgroundView setImage:[UIImage imageForName:@"content_portrait_bg" type:@"png"]];
#pragma mark - add by lc
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _contentView.top += 20;
    }
}



#pragma mark --------程序扩展     --------
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration{
    
    [super relayoutForInterfaceOrientation:interfaceOrientation withDuration:duration];
    
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self relayoutElementsForLandscapeInContentView];
    }
    else{
        [self relayoutElementsForPortraitInContentView];
    }
    [_dragRefreshViewController relayoutForInterfaceOrientation:interfaceOrientation withDuration:duration];
    [_contentViewBackgroundView setFrame:_contentView.bounds];
    //  [[self contentTableView] reloadData];
}

#pragma mark --------系统自带  --------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0.0,0.0,MAINSCREEN_PORTRAIT_WIDTH,MAINSCREEN_PORTRAIT_HEIGHT)];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self loadContentView];
    [self loadDragRefreshViewController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
#pragma mark - add by lc
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}
#pragma end

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    if (_contentView) _contentView = nil;
    if (_contentViewBackgroundView) _contentViewBackgroundView = nil;
    if (_dragRefreshViewController) _dragRefreshViewController = nil;
}



@end
