//
//  ContentViewController.h
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

/**
 *    @brief    继承CommonViewController，包含一个内容显示tableView，以及为tableview提供了上拉/下拉刷新，支持选择性使用刷新方式，定制刷新提示文字等
 */


#import "CommonViewController.h"
#import "DragRefreshViewController.h"


@interface ContentViewController : CommonViewController
{
    UIView *_contentView;                                             // 内容显示区域
    UIImageView *_contentViewBackgroundView;                         // 内容显示区域背景
    DragRefreshViewController *_dragRefreshViewController;     // 下拉刷新控制器
}


/**
 *    @brief    内容视图，属于显示内容的底层容器，放置与Controller自身的view之上
 */
@property(nonatomic,readonly,strong) UIView *contentView;

/**
 *    @brief    内容显示区域背景
 */
@property(nonatomic,readonly,strong) UIImageView *contentViewBackgroundView;

- (UITableView *)contentTableView;
- (UILabel *)leftTitleLabel;
- (UILabel *)middleTitleLabel;
- (UILabel *)rightTitleLabel;
- (UIView *)contentTitleView;
- (UIImageView *)contentTitleViewBackgroundView;

- (RefreshDirection)refreshDirection;
- (BOOL)isNeedPushDownRefresh;
- (BOOL)isNeedPushUpRefresh;
- (BOOL)isLoading;
- (void)setIsNeedPushDownRefresh:(BOOL)isNeedPushDownRefresh;
- (void)setIsNeedPushUpRefresh:(BOOL)isNeedPushUpRefresh;
- (void)setTextPullToDown:(NSString *)textPullToDown;
- (void)setTextPullToUp:(NSString *)textPullToUp;
- (void)setTextRelease:(NSString *)textRelease;
- (void)setTextLoading:(NSString *)textLoading;

- (void)setIsNeedSearch:(BOOL)isNeedSearch;

- (void)stopLoading;
- (void)startLoading;
- (void)setContentTitleWithLeft:(NSString *)leftTitle middle:(NSString *)middleTitle right:(NSString *) rightTitle;

@end
