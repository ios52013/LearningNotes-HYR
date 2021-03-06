//
//  DragRefreshViewController.h
//  PACDMS_ipad
//
//  Created by yangfeiyue on 12-8-16.
//  Copyright (c) 2012年 zbkc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CONTENTTABLEVIEW_HEADER_HEIGHT        54.0
#define CONTENTTABLEVIEW_CELL_HEIGHT              60.0

#define CONTENTTITLEVIEW_LEFTLABEL_WIDTH     200.0
#define CONTENTTITLEVIEW_RIGHTLABEL_WIDTH   150.0

#define TABELVIEW_CELL_HEIGHT             60.0

#define SEARCHBAR_HEIGHT      50.0
#define SHOWSEARCHBAR_OFFSET  50.0

/**
 *	@brief	刷新方向
 */
typedef enum{
	PushDownRefresh = 0, /**< 下拉刷新 */
	PushUpRefresh /**< 上拉刷新 */
}RefreshDirection;


@protocol DragRefreshViewControllerDelegate;
@protocol DragRefreshViewControllerSearchDelegate;
#define kSeparatorLineViewTag 101

/**
 *	@brief	上下拉刷新控制器类，提供上下刷新接口以及内容搜索接口
 */
@interface DragRefreshViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
  UIView *_contentTitleView;                                                   //表格标题显示区域
  UIImageView *_contentTitleViewBackgroundView;                  //表格标题显示区域背景
  UITableView *_contentTableView;                                         //表格内容显示区域
  UILabel *_leftTitleLabel;                                                      //表格标题居左显示
  UILabel *_middleTitleLabel;                                                  //表格标题居中显示
  UILabel *_rightTitleLabel;                                                    //表格标题居右显示
  
  /*tableView刷新相关变量*/
    //下拉刷新
  BOOL _isNeedPushDownRefresh;                                         //是否开启下拉刷新功能，默认不开启
  UIView *_refreshHeaderView;                                             //刷新提示区域
  UILabel *_refreshHeaderLabel;                                           //刷新提示区域显示的标题
  UIImageView *_refreshHeaderArrow;                                  //刷新提示区域显示的图片
  UIActivityIndicatorView *_refreshHeaderSpinner;               //刷新提示区域显示的进度指示条
                                                                
  //上拉刷新
  BOOL _isNeedPushUpRefresh;                                             //是否开启上拉刷新功能，默认不开启
  UIView *_refreshFooterView;                                              //刷新提示区域
  UILabel *_refreshFooterLabel;                                            //刷新提示区域显示的标题
  UIImageView *_refreshFooterArrow;                                  //刷新提示区域显示的图片
  UIActivityIndicatorView *_refreshFooterSpinner;               //刷新提示区域显示的进度指示条
  
  BOOL _isDragging;                                                               //是否正在滑动
  BOOL _isLoading;                                                                 //是否正在刷新
  NSString *_textPullToDown;                                                //刷新提示区域标题内容-下拉刷新
  NSString *_textPullToUp;                                                    //刷新提示区域标题内容-上拉刷新
  NSString *_textRelease;                                                     //刷新提示区域标题内容-准备刷新
  NSString *_textLoading;                                                      //刷新提示区域标题内容-正在刷新
  RefreshDirection _refreshDirection;                                    //用来标记是上拉刷新还是下拉刷新
  
  //搜索框
  UISearchBar *_searchBar;                                                  //搜索框
  UIView *_headerView;                                                         //表格标题显示区域
  BOOL _isNeedSearch;                                                         //是否需要搜索功能
  
}

/**
 *	@brief	contentTitleView提供了左中右三个标题显示label，可以根据自身需求设置
 */
@property(nonatomic,readonly,strong)UIView *contentTitleView;

/**
 *	@brief	contentTableView 是内容的主要显示视图，其放置与contentView之上。
 */
@property(nonatomic,readonly,strong)UITableView *contentTableView;

/**
 *	@brief	标题栏背景
 */
@property(nonatomic,readonly,strong)UIImageView *contentTitleViewBackgroundView;

/**
 *	@brief	左边标题
 */
@property(nonatomic,readonly,strong)UILabel *leftTitleLabel;

/**
 *	@brief	中间标题
 */
@property(nonatomic,readonly,strong)UILabel *middleTitleLabel;

/**
 *	@brief	右边标题
 */
@property(nonatomic,readonly,strong)UILabel *rightTitleLabel;

/**
 *	@brief	是否正在请求数据
 */
@property(nonatomic,readonly,assign)BOOL isLoading;

/**
 *	@brief	是否需要下拉刷新功能，设置为YES时，可以使用下拉刷新
 */
@property(nonatomic,assign)BOOL isNeedPushDownRefresh;

/**
 *	@brief	是否需要上拉刷新功能，设置为YES时，可以使用上拉刷新
 */
@property(nonatomic,assign)BOOL isNeedPushUpRefresh;

/**
 *	@brief	下拉刷新显示的提示信息
 */
@property(nonatomic,copy)NSString *textPullToDown;

/**
 *	@brief	上拉刷新显示的提示信息
 */
@property(nonatomic,copy)NSString *textPullToUp;

/**
 *	@brief	松开刷新显示的提示信息
 */
@property(nonatomic,copy)NSString *textRelease;

/**
 *	@brief	正在刷新显示的提示信息
 */
@property(nonatomic,copy)NSString *textLoading;

/**
 *	@brief	刷新方向
 */
@property (nonatomic,assign)RefreshDirection refreshDirection;

@property (nonatomic, strong) UISearchBar *searchBar;

/**
 *	@brief	是否需要搜索功能，设置为YES时，提供搜索
 */
@property(nonatomic,assign)BOOL isNeedSearch;

/**
 *	@brief	上下拉代理 DragRefreshViewControllerDelegate
 */
@property (nonatomic, assign) id delegate;

/**
 *	@brief	搜索代理 DragRefreshViewControllerSearchDelegate
 */
@property (nonatomic, assign) id searchDelegate;


/**
 *	@brief	设置内容的左，中，右标题
 *
 *	@param 	leftTitle 	 左标题
 *	@param 	middleTitle  中间标题
 *	@param 	rightTitle 	 右标题
 */
- (void)setContentTitleWithLeft:(NSString *)leftTitle middle:(NSString *)middleTitle right:(NSString *)rightTitle;

/**
 *	@brief	开始刷新等待显示
 */
- (void)startLoading;

/**
 *	@brief	停止刷新等待显示
 */
- (void)stopLoading;

/**
 *	@brief	刷新接口，提供给子类继承
 */
- (void)refresh;

/**
 *	@brief	设置cell分割线的风格
 *
 *	@param 	tableViewCellSeparatorView 分割线图片
 */
- (void)resetTableViewCellSeparatorStyle:(UIImageView *)tableViewCellSeparatorView;

/**
 *	@brief	设置cell的背景
 *
 *	@param 	cell 需要设置背景的cell对象
 */
- (void)resetCellSelectedBackgroundView:(UITableViewCell *)cell;
//- (void)dismissSearchBar;
@end


/**
 *	@brief	上下拉代理
 */
@protocol DragRefreshViewControllerDelegate <NSObject>
@optional

/**
 *	@brief	重新构造 cell 的工厂方法
 *
 *	@param 	cell        需要构造的 cell 对象
 *	@param 	indexPath   cell 对象 所处的位置
 */
- (void)tableViewCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	@brief	重用 cell 的工厂方法
 *
 *	@param 	cell        需要构造的 cell 对象
 *	@param 	indexPath   cell 对象 所处的位置
 */
- (void)tableViewdequeueReusableCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	@brief	设置cell分割线的风格
 *
 *	@param 	tableViewCellSeparatorView 分割线图片
 */
- (void)resetTableViewCellSeparatorStyle:(UIImageView *)tableViewCellSeparatorView;

/**
 *	@brief	设置cell的背景
 *
 *	@param 	cell 需要设置背景的cell对象
 */
- (void)resetCellSelectedBackgroundView:(UITableViewCell *)cell;

/**
 *	@brief	配置 tableView 的section数
 *
 *	@param 	tableView 需要设置section数量的UITableView
 *
 *	@return  需要配置的 section 数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

/**
 *	@brief	配置 tableView 在section下的行数
 *
 *	@param 	tableView 需要设置行数的UITableView
 *	@param 	section 需要设置行数的section
 *
 *	@return  需要配置的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *	@brief	配置 indexPath 位置的行高
 *
 *	@param 	tableView 需要配置行高的UITableView
 *	@param 	indexPath 需要配置行高的cell定位
 *
 *	@return  配置的行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	@brief	配置 section 的 header高度
 *
 *	@param 	tableView 需要配置header高度的UITableView
 *	@param 	section 需要配置header高度的section
 *
 *	@return  配置的header高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

/**
 *	@brief	配置 indexPath 位置的cell
 *
 *	@param 	tableView 需要配置cell的UITableView
 *	@param 	indexPath 需要配置cell的定位
 *
 *	@return  配置的cell对象
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	@brief	配置 section 的HeaderView
 *
 *	@param 	tableView 需要配置HeaderView的UITableView
 *	@param 	section 需要配置HeaderView的section
 *
 *	@return  配置的HeaderView对象
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

/**
 *	@brief	选中 indexPath 位置的 cell后的操作
 *
 *	@param 	tableView 触发操作的tableView
 *	@param 	indexPath 被选中cell的定位
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	@brief	取消选中 indexPath 位置的 cell后的操作
 *
 *	@param 	tableView 触发操作的tableView
 *	@param 	indexPath 取消选中cell的定位
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	@brief	刷新操作
 */
- (void)refresh;

@end


/**
 *	@brief	搜索代理
 */
@protocol DragRefreshViewControllerSearchDelegate <NSObject>
/**
 *	@brief	取消搜索
 */
- (void)cancelSearch;

/**
 *	@brief	开始搜索
 */
- (void)didSearchWithSearchBar:(UISearchBar *)searchBar;

//- (void)didSearchIsNo;
@end

