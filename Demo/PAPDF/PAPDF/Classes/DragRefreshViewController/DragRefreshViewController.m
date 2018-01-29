//
//  DragRefreshViewController.m
//  PACDMS_ipad
//
//  Created by yangfeiyue on 12-8-16.
//  Copyright (c) 2012年 zbkc. All rights reserved.
//

#import "DragRefreshViewController.h"
#import "UIControl+extension.h"
#import "Global.h"


#define REFRESH_HEADER_HEIGHT 52.0f
static float preScrollViewContentOffsetY = 0;


@interface DragRefreshViewController (private)

/**
 *	@brief	触发自定义刷新操作的间接刷新方法
 */
- (void)defaultRefresh;

/**
 *	@brief	转换到横屏布局
 */
- (void)relayoutElementsForLandscapeInContentView;

/**
 *	@brief	转换到竖屏布局
 */
- (void)relayoutElementsForPortraitInContentView;

/**
 *	@brief	显示搜索框
 */
- (void)presentSearchBar;
@end

@implementation DragRefreshViewController

- (id)init {
  if (self = [super init]) {
    _isNeedSearch = NO;
    _textPullToDown = @"下拉可以刷新...";
    _textPullToUp = @"上拉可以刷新...";
    _textRelease = @"松开即可刷新...";
    _textLoading = @"刷新中...";
  }
  return self;
}


/**
 *	@brief	加载HeaderView ，用于显示标题
 */
- (void)loadHeaderView {
  _headerView = [[UIView alloc] initWithFrame:CGRectZero];
  [_headerView setBackgroundColor:[UIColor clearColor]];
}

/**
 *	@brief	加载内容标题
 */
- (void)loadTitleLabelToContentTitleView{
  _leftTitleLabel = [UILabel labelWithFrame:CGRectMake(0.0, 0.0,
                                                        CONTENTTITLEVIEW_LEFTLABEL_WIDTH,
                                                        CONTENTTABLEVIEW_HEADER_HEIGHT)
                                        text:@""
                                        font:BOLDSYSTEMFONT(22)
                                   textColor:SUBTITLE_TEXTCOLOR];
  _middleTitleLabel = [UILabel labelWithFrame:CGRectMake(CONTENTTITLEVIEW_LEFTLABEL_WIDTH,
                                                          0.0,
                                                          CONTENTTABLEVIEW_PORTRAIT_WIDTH - 350.0,
                                                          CONTENTTABLEVIEW_HEADER_HEIGHT)
                                          text:@""
                                          font:BOLDSYSTEMFONT(22)
                                     textColor:SUBTITLE_TEXTCOLOR];
  _rightTitleLabel = [UILabel labelWithFrame:CGRectMake(CONTENTTABLEVIEW_PORTRAIT_WIDTH - CONTENTTITLEVIEW_RIGHTLABEL_WIDTH,
                                                         0.0,
                                                         CONTENTTITLEVIEW_RIGHTLABEL_WIDTH,
                                                         CONTENTTABLEVIEW_HEADER_HEIGHT)
                                         text:@""
                                         font:BOLDSYSTEMFONT(22)
                                    textColor:SUBTITLE_TEXTCOLOR];
  [_contentTitleView addSubview:_leftTitleLabel];
  [_contentTitleView addSubview:_middleTitleLabel];
  [_contentTitleView addSubview:_rightTitleLabel];
}


/**
 *	@brief	加载内容标题栏
 */
- (void)loadContentTitleView {
  CGFloat contentTitleViewWidth = 0.0;
  if (UIInterfaceOrientationIsLandscape([Global interfaceOrientation])) {
    contentTitleViewWidth = CONTENTTABLEVIEW_LANDSCAPE_WIDTH;
  }
  else {
    contentTitleViewWidth = CONTENTTABLEVIEW_PORTRAIT_WIDTH;
  }
  _contentTitleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, contentTitleViewWidth, CONTENTTABLEVIEW_HEADER_HEIGHT)];
  [_headerView addSubview:_contentTitleView];
  _contentTitleViewBackgroundView = [[UIImageView alloc] initWithFrame:_contentTitleView.bounds];
  [_contentTitleViewBackgroundView setImage:[UIImage imageForName:@"contenttitle_portrait_bg" type:@"png"]];
  [_contentTitleView addSubview:_contentTitleViewBackgroundView];
  [self loadTitleLabelToContentTitleView];
}


/**
 *	@brief	加载内容显示tableview
 */
- (void)loadContentTableView {
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
  _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    contentTableViewWidth,
                                                                    contentTableViewHeight)];
  [_contentTableView setBackgroundColor:[UIColor clearColor]];
  [_contentTableView setRowHeight:CONTENTTABLEVIEW_CELL_HEIGHT];
  [_contentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [_contentTableView setDelegate:self];
  [_contentTableView setDataSource:self];
  [_contentTableView setShowsVerticalScrollIndicator:NO];
  [self.view addSubview:_contentTableView];
}

/**
 *	@brief	加载searchBar
 */
- (void)loadSearchBar {
  CGFloat searchBarWidth = 0.0;
  if (UIInterfaceOrientationIsLandscape([Global interfaceOrientation])) {
    searchBarWidth = CONTENTTABLEVIEW_LANDSCAPE_WIDTH;
  }
  else {
    searchBarWidth = CONTENTTABLEVIEW_PORTRAIT_WIDTH;
  }
  _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, searchBarWidth, SEARCHBAR_HEIGHT)];
  _searchBar.delegate = self;
  _searchBar.placeholder = @"请输入要搜索的文件名";
  _searchBar.hidden = YES;
  _searchBar.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:200.0/255.0 alpha:1];
  [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
  _searchBar.showsCancelButton = NO;
  for(id cc in _searchBar.subviews){
    if([cc isKindOfClass:UIButton.class]){
      UIButton *searchButton = (UIButton *)cc;
      [searchButton setTitle:@"取消搜索" forState:UIControlStateNormal];
    }
  }
//  _searchBar.layer.cornerRadius = 6.0;
  [_headerView addSubview:_searchBar];
}

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark =======	逻辑处理	 =======																																									
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark ----	 公有接口  ----
- (NSInteger)numberOfRowsInSection:(NSInteger)section{return 0;}

/**
 *	@brief	重新配置cell内容抽象方法，供子类重写
 *
 *	@param 	cell 	配置内容的cell
 *	@param 	indexPath 	cell在tableView中的indexPath
 */
- (void)tableViewCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{

}


/**
 *	@brief	重用cell内容的抽象方法，供子类重写
 *
 *	@param 	cell 	重用内容的cell
 *	@param 	indexPath 	cell在tableView中的indexPath
 */
- (void)tableViewdequeueReusableCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{

}


/**
 *	@brief	设置cell的selected状态背景
 *
 *	@param 	cell 	重置状态背景的cell对象
 */
- (void)resetCellSelectedBackgroundView:(UITableViewCell *)cell {
  UIImageView *cellSelectedBackgroundView = [[UIImageView alloc] init];
  UIImage *image = [[UIImage imageForName:@"common_selectedcell_bg" type:@"png"]  stretchableImageWithLeftCapWidth:20.0
                                                                                                      topCapHeight:20.0];
  if (UIInterfaceOrientationIsPortrait([Global interfaceOrientation])) {
    [cellSelectedBackgroundView setFrame:CGRectMake(2.0,
                                                    0.0,
                                                    CONTENTTABLEVIEW_PORTRAIT_WIDTH-4.0,
                                                    CONTENTTABLEVIEW_CELL_HEIGHT)];
    [cellSelectedBackgroundView setImage:image];
  }else{
    [cellSelectedBackgroundView setFrame:CGRectMake(2.0,
                                                    0.0,
                                                    CONTENTTABLEVIEW_LANDSCAPE_WIDTH-4.0,
                                                    CONTENTTABLEVIEW_CELL_HEIGHT)];
    [cellSelectedBackgroundView setImage:image];
  }
  [cell setSelectedBackgroundView:cellSelectedBackgroundView];
  //SAFE_RELEASE(cellSelectedBackgroundView);
}


/**
 *	@brief	重置cell的分割线
 *
 *	@param 	tableViewCellSeparatorView 	分割线
 */
- (void)resetTableViewCellSeparatorStyle:(UIImageView *)tableViewCellSeparatorView {
  if (UIInterfaceOrientationIsPortrait([Global interfaceOrientation])) {
    [tableViewCellSeparatorView setFrame:CGRectMake(5.0f,
                                                    CONTENTTABLEVIEW_CELL_HEIGHT - 1.0f,
                                                    CONTENTTABLEVIEW_PORTRAIT_WIDTH - 10.0f,
                                                    1.0f)];
    [tableViewCellSeparatorView setImage:[UIImage imageForName:@"common_separator_portrait" type:@"png"]];
  }else{
    [tableViewCellSeparatorView setFrame:CGRectMake(5.0f,
                                                    CONTENTTABLEVIEW_CELL_HEIGHT - 1.0f,
                                                    CONTENTTABLEVIEW_LANDSCAPE_WIDTH - 10.0f,
                                                    1.0f)];
    [tableViewCellSeparatorView setImage:[UIImage imageForName:@"common_separator_landscape" type:@"png"]];
  }
}



/**
 *	@brief	设置内容标题栏标题
 *
 *	@param 	leftTitle 	左标题
 *	@param 	middleTitle 	中间标题
 *	@param 	rightTitle 	右标题
 */
- (void)setContentTitleWithLeft:(NSString *)leftTitle middle:(NSString *)middleTitle right:(NSString *)rightTitle {
  if (leftTitle)
    [_leftTitleLabel setText:leftTitle];
  else
    [_leftTitleLabel setText:@""];
  if (leftTitle)
    [_middleTitleLabel setText:middleTitle];
  else
    [_middleTitleLabel setText:@""];
  if (leftTitle)
    [_rightTitleLabel setText:rightTitle];
  else
    [_rightTitleLabel setText:@""];
}


/*-----------------tableView刷新--------------------*/
  //下拉刷新
/**
 *	@brief	添加上拉刷新提示显示视图
 */
- (void)addPullToRefreshHeader {
  _refreshHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
  _refreshHeaderView.backgroundColor = [UIColor clearColor];
  [_refreshHeaderView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
  _refreshHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, REFRESH_HEADER_HEIGHT)];
  _refreshHeaderLabel.backgroundColor = [UIColor clearColor];
  _refreshHeaderLabel.textColor = [UIColor grayColor];
  _refreshHeaderLabel.font = [UIFont systemFontOfSize:16.0];
  _refreshHeaderArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down.png"]];
  _refreshHeaderArrow.frame = CGRectMake((REFRESH_HEADER_HEIGHT - 27) / 2,
                                         (REFRESH_HEADER_HEIGHT - 44) / 2,
                                         27, 44);
  _refreshHeaderSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  _refreshHeaderSpinner.frame = CGRectMake((REFRESH_HEADER_HEIGHT - 20) / 2, (REFRESH_HEADER_HEIGHT - 20) / 2, 20, 20);
  _refreshHeaderSpinner.hidesWhenStopped = YES;
  [_refreshHeaderView addSubview:_refreshHeaderLabel];
  [_refreshHeaderView addSubview:_refreshHeaderArrow];
  [_refreshHeaderView addSubview:_refreshHeaderSpinner];
  [_contentTableView addSubview:_refreshHeaderView];
  [_refreshHeaderView setHidden:YES];
}


  //上拉刷新
/**
 *	@brief	添加上拉刷新提示显示视图
 */
- (void)addPullToRefreshFooter {
  _refreshFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  _refreshFooterView.backgroundColor = [UIColor clearColor];
  [_refreshFooterView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
  _refreshFooterLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, REFRESH_HEADER_HEIGHT)];
  _refreshFooterLabel.backgroundColor = [UIColor clearColor];
  _refreshFooterLabel.textColor = [UIColor grayColor];
  _refreshFooterLabel.font = [UIFont systemFontOfSize:16.0];
  _refreshFooterArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_up.png"]];
  _refreshFooterArrow.frame = CGRectMake((REFRESH_HEADER_HEIGHT - 27) / 2,
                                         (REFRESH_HEADER_HEIGHT - 44) / 2,
                                         27, 44);
  _refreshFooterSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  _refreshFooterSpinner.frame = CGRectMake((REFRESH_HEADER_HEIGHT - 20) / 2, (REFRESH_HEADER_HEIGHT - 20) / 2, 20, 20);
  _refreshFooterSpinner.hidesWhenStopped = YES;
  [_refreshFooterView addSubview:_refreshFooterLabel];
  [_refreshFooterView addSubview:_refreshFooterArrow];
  [_refreshFooterView addSubview:_refreshFooterSpinner];
  [_contentTableView addSubview:_refreshFooterView];
  [_refreshFooterView setHidden:YES];
}


/**
 *	@brief	刷新开始，获取数据
 */
- (void)startLoading {
  if (_isNeedPushDownRefresh && (_refreshDirection == PushDownRefresh)) {
    _isLoading = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _contentTableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    _refreshHeaderLabel.text = self.textLoading;
    _refreshHeaderArrow.hidden = YES;
    [_refreshHeaderSpinner startAnimating];
    [UIView commitAnimations];
    [self defaultRefresh];
  }
  else if (_isNeedPushUpRefresh && (_refreshDirection == PushUpRefresh)) {
    _isLoading = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _contentTableView.contentInset = UIEdgeInsetsMake(0, 0,REFRESH_HEADER_HEIGHT, 0);
    _refreshFooterLabel.text = self.textLoading;
    _refreshFooterArrow.hidden = YES;
    [_refreshFooterSpinner startAnimating];
    [UIView commitAnimations];
    [self defaultRefresh];
  }
}
/**
 *	@brief	停止刷新
 */
- (void)stopLoading {
  if (_isNeedPushDownRefresh && (_refreshDirection == PushDownRefresh)) {
    _isLoading = NO;
      // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    _contentTableView.contentInset = UIEdgeInsetsZero;
    [_refreshHeaderArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
  }
  else if (_isNeedPushUpRefresh && (_refreshDirection == PushUpRefresh)) {
    _isLoading = NO;
      // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    _contentTableView.contentInset = UIEdgeInsetsZero;
    [_refreshFooterArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
  }
  
  if ((!_isNeedSearch && self.contentTableView.contentSize.height < PAGESIZE * CONTENTTABLEVIEW_CELL_HEIGHT ) || (_isNeedSearch && self.contentTableView.contentSize.height < PAGESIZE * CONTENTTABLEVIEW_CELL_HEIGHT + SEARCHBAR_HEIGHT)) {
    [_refreshFooterView setHidden:YES];
  }
  else {
    [_refreshFooterView setHidden:NO];
  }
    //  if (self.contentTableView.contentSize.height > self.contentTableView.frame.size.height)
    //    [_refreshFooterView setFrame:CGRectMake((_contentTableView.frame.size.width - 270) / 2, _contentTableView.contentSize.height, 270, REFRESH_HEADER_HEIGHT)];
}

- (void)refresh {
  
}

/**
 *	@brief	触发自定义刷新操作的间接刷新方法
 */
- (void)defaultRefresh {
  if (_delegate && [_delegate respondsToSelector:@selector(refresh)]) {
    [_delegate refresh];
  }
  else {
    [self refresh];
    if (_isNeedPushDownRefresh || _isNeedPushUpRefresh)
      [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
  }
}


/**
 *	@brief	设置是否需要添加搜索功能
 *
 *	@param 	isNeedSearch 如果为YES，则添加，反之为NO，不添加，默认为NO
 */
- (void)setIsNeedSearch:(BOOL)isNeedSearch {
  if (!_isNeedSearch) {
    [self presentSearchBar];
  }
  _isNeedSearch = isNeedSearch;
  [_contentTableView reloadData];
}

/*-------------------------------------*/

#pragma mark ----	 私有接口	  ----				
/**
 *	@brief	横屏布局
 */
- (void)relayoutElementsForLandscapeInContentView{
  CGFloat titleOriginY = 0.0;
  CGFloat headerHeight = CONTENTTABLEVIEW_HEADER_HEIGHT;
  if (_isNeedSearch) {
    titleOriginY = SEARCHBAR_HEIGHT;
    headerHeight += SEARCHBAR_HEIGHT;
  }
  [_headerView setFrame:CGRectMake(0.0, 0.0, CONTENTTABLEVIEW_LANDSCAPE_WIDTH, headerHeight)];
  [_contentTitleView setFrame:CGRectMake(0.0, titleOriginY, CONTENTTABLEVIEW_LANDSCAPE_WIDTH,CONTENTTABLEVIEW_HEADER_HEIGHT)];
  
  CGRect searchBarFrame = _searchBar.frame;
  searchBarFrame.size.width = CONTENTTABLEVIEW_LANDSCAPE_WIDTH;
  [_searchBar setFrame:searchBarFrame];
  
  [_contentTitleViewBackgroundView setFrame:_contentTitleView.bounds];
  [_contentTitleViewBackgroundView setImage:[UIImage imageForName:@"contenttitle_landscape_bg" type:@"png"]];
  [_contentTableView setFrame: CGRectMake(0,
                                          0,
                                          CONTENTTABLEVIEW_LANDSCAPE_WIDTH,
                                          CONTENTTABLEVIEW_LANDSCAPE_HEIGHT)];
  [_leftTitleLabel setFrame:CGRectMake(0.0, 0.0, CONTENTTITLEVIEW_LEFTLABEL_WIDTH, CONTENTTABLEVIEW_HEADER_HEIGHT)];
  [_middleTitleLabel setFrame:CGRectMake(CONTENTTITLEVIEW_LEFTLABEL_WIDTH,
                                         0.0,
                                         CONTENTTABLEVIEW_LANDSCAPE_WIDTH - 350.0,
                                         CONTENTTABLEVIEW_HEADER_HEIGHT)];
  [_rightTitleLabel setFrame:CGRectMake(CONTENTTABLEVIEW_LANDSCAPE_WIDTH - CONTENTTITLEVIEW_RIGHTLABEL_WIDTH,
                                        0.0,
                                        CONTENTTITLEVIEW_RIGHTLABEL_WIDTH,
                                        CONTENTTABLEVIEW_HEADER_HEIGHT)];
}


/**
 *	@brief	竖屏布局
 */
- (void)relayoutElementsForPortraitInContentView {
  CGFloat titleOriginY = 0.0;
  CGFloat headerHeight = CONTENTTABLEVIEW_HEADER_HEIGHT;
  if (_isNeedSearch) {
    titleOriginY = SEARCHBAR_HEIGHT;
    headerHeight += SEARCHBAR_HEIGHT;
  }
  
  [_headerView setFrame:CGRectMake(0.0, 0.0, CONTENTTABLEVIEW_PORTRAIT_WIDTH, headerHeight)];
  [_contentTitleView setFrame:CGRectMake(0.0,titleOriginY, CONTENTTABLEVIEW_PORTRAIT_WIDTH, CONTENTTABLEVIEW_HEADER_HEIGHT)];
  
  CGRect searchBarFrame = _searchBar.frame;
  searchBarFrame.size.width = CONTENTTABLEVIEW_PORTRAIT_WIDTH;
  [_searchBar setFrame:searchBarFrame];
  
  [_contentTitleViewBackgroundView setFrame:_contentTitleView.bounds];
  [_contentTitleViewBackgroundView setImage:[UIImage imageForName:@"contenttitle_portrait_bg" type:@"png"]];
  [_contentTableView setFrame: CGRectMake(0,
                                          0,
                                          CONTENTTABLEVIEW_PORTRAIT_WIDTH,
                                          CONTENTTABLEVIEW_PORTRAIT_HEIGHT)];
  [_leftTitleLabel setFrame:CGRectMake(0.0, 0.0, CONTENTTITLEVIEW_LEFTLABEL_WIDTH, CONTENTTABLEVIEW_HEADER_HEIGHT)];
  [_middleTitleLabel setFrame:CGRectMake(CONTENTTITLEVIEW_LEFTLABEL_WIDTH,
                                         0.0,
                                         CONTENTTABLEVIEW_PORTRAIT_WIDTH - 350.0,
                                         CONTENTTABLEVIEW_HEADER_HEIGHT)];
  [_rightTitleLabel setFrame:CGRectMake(CONTENTTABLEVIEW_PORTRAIT_WIDTH - CONTENTTITLEVIEW_RIGHTLABEL_WIDTH,
                                        0.0,
                                        CONTENTTITLEVIEW_RIGHTLABEL_WIDTH,
                                        CONTENTTABLEVIEW_HEADER_HEIGHT)];
}


/*-----------------tableView下拉刷新--------------------*/

/**
 *	@brief	刷新完成动画执行完成以后执行，显示完成后提示信息和布局
 *
 *	@param 	animationID 	完成的动画id
 *	@param 	finished        
 *	@param 	context         上下文参数，如果有额外的数据，通过这个参数传递到方法中来。
 */
- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
  if (_refreshDirection == PushDownRefresh) {
      // Reset the header
    _refreshHeaderLabel.text = self.textPullToDown;
    _refreshHeaderArrow.hidden = NO;
    [_refreshHeaderSpinner stopAnimating];
  }else if (_refreshDirection == PushUpRefresh) {
      // Reset the footer
    _refreshFooterLabel.text = self.textPullToUp;
    _refreshFooterArrow.hidden = NO;
    [_refreshFooterSpinner stopAnimating];
  }
}


/**
 *	@brief	设置是否开始下拉刷新功能
 *
 *	@param 	isNeedPushDownRefresh YES表示开启，NO表示关闭，默认为NO
 */
- (void)setIsNeedPushDownRefresh:(BOOL)isNeedPushDownRefresh {
  [_refreshHeaderView setFrame:CGRectMake((_contentTableView.frame.size.width - 270)/2, 0 - REFRESH_HEADER_HEIGHT, 270, REFRESH_HEADER_HEIGHT)];
  [_refreshHeaderView setHidden:!isNeedPushDownRefresh];
  _isNeedPushDownRefresh = isNeedPushDownRefresh;
}


/**
 *	@brief	设置是否开启上拉刷新功能
 *
 *	@param 	isNeedPushUpRefresh	YES表示开启，NO表示关闭，默认为NO
 */
- (void)setIsNeedPushUpRefresh:(BOOL)isNeedPushUpRefresh {
  if (_contentTableView.contentSize.height > _contentTableView.frame.size.height) {
    CGFloat originY = _contentTableView.contentSize.height;
//    if (_isNeedSearch) {
//      originY += SEARCHBAR_HEIGHT;
//    }
    [_refreshFooterView setFrame:CGRectMake((_contentTableView.frame.size.width - 270) / 2, originY, 270, REFRESH_HEADER_HEIGHT)];
    [_refreshFooterView setHidden:!isNeedPushUpRefresh];
    if (self.contentTableView.contentSize.height < PAGESIZE * CONTENTTABLEVIEW_CELL_HEIGHT) {
      [_refreshFooterView setHidden:YES];
    }
    else {
      [_refreshFooterView setHidden:NO];
    }
    _isNeedPushUpRefresh = isNeedPushUpRefresh;
  }
}

/*-----------------searchBar 逻辑--------------------*/

/**
 *	@brief	呈现searchBar
 */
- (void)presentSearchBar {
  if(UIInterfaceOrientationIsLandscape(kCurrentOrientation)) {
    _searchBar.frame = CGRectMake(0, 0, CONTENTTABLEVIEW_LANDSCAPE_WIDTH, SEARCHBAR_HEIGHT);
    _contentTitleView.frame = CGRectMake(0, SEARCHBAR_HEIGHT, CONTENTTABLEVIEW_LANDSCAPE_WIDTH, CONTENTTABLEVIEW_HEADER_HEIGHT);
  }
  else {
    _searchBar.frame = CGRectMake(0, 0, CONTENTTABLEVIEW_PORTRAIT_WIDTH, SEARCHBAR_HEIGHT);
    _contentTitleView.frame = CGRectMake(0, SEARCHBAR_HEIGHT, CONTENTTABLEVIEW_PORTRAIT_WIDTH, CONTENTTABLEVIEW_HEADER_HEIGHT);
  }
  CGRect headerViewFrame = _headerView.frame;
  headerViewFrame.size.height += SEARCHBAR_HEIGHT;
  [_headerView setFrame:headerViewFrame];
  [_refreshFooterView setFrame:CGRectMake((_contentTableView.frame.size.width - 270) / 2, _contentTableView.contentSize.height + SEARCHBAR_HEIGHT, 270, REFRESH_HEADER_HEIGHT)];
  [_searchBar setHidden:NO];
}



#pragma mark -------- tableView datasource -----------
/**
 *	@brief 以下 UITableView 的代理方法都将转移给代理类执行，即ContentViewController，目的是为了兼容3.0之前的版本中调用了ContentViewController的代理方法的类，
 *          这样做等于是吧接口全部转移到ContentViewController类。
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (_delegate && [_delegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
    return [_delegate numberOfSectionsInTableView:tableView];
  }
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
    return [_delegate tableView:tableView numberOfRowsInSection:section];
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
    return [_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
  }
  return CONTENTTABLEVIEW_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
    return [_delegate tableView:tableView heightForHeaderInSection:section];
  }
  if ( !_searchBar.hidden) {
    return CONTENTTABLEVIEW_HEADER_HEIGHT+SEARCHBAR_HEIGHT;
  }
  return CONTENTTABLEVIEW_HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [_delegate tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
    return [_delegate tableView:tableView cellForRowAtIndexPath:indexPath];
  }
  
  static NSString *CellIdentify = @"CellIdentify";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentify];
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [lineView setTag:kSeparatorLineViewTag];
    [cell.contentView addSubview:lineView];
   
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewCell:cellForRowAtIndexPath:)]) {
      [_delegate tableViewCell:cell cellForRowAtIndexPath:indexPath];
    }
    else {
      [self tableViewCell:cell cellForRowAtIndexPath:indexPath];
    }
    
  }
  UIImageView *separatorView = (UIImageView *)[cell.contentView viewWithTag:kSeparatorLineViewTag];
  if (_delegate && [_delegate respondsToSelector:@selector(resetCellSelectedBackgroundView:)]) {
    [_delegate resetCellSelectedBackgroundView:cell];
  }
  else {
    [self resetCellSelectedBackgroundView:cell];
  }
  if (_delegate && [_delegate respondsToSelector:@selector(resetTableViewCellSeparatorStyle:)]) {
    [_delegate resetTableViewCellSeparatorStyle:separatorView];
  }
  else {
    [self resetTableViewCellSeparatorStyle:separatorView];
  }
  if (_delegate && [_delegate respondsToSelector:@selector(tableViewdequeueReusableCell:cellForRowAtIndexPath:)]) {
    [_delegate tableViewdequeueReusableCell:cell cellForRowAtIndexPath:indexPath];
  }
  else {
    [self tableViewdequeueReusableCell:cell cellForRowAtIndexPath:indexPath];
  }
  return  cell;
}

#pragma mark -------- tableView delegate  ------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
    return [_delegate tableView:tableView viewForHeaderInSection:section];
  }
  return _headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [_delegate tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
    [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
  }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_delegate && [_delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
    [_delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
  }
}

#pragma mark -------- UIScrollViewDelegate ---------------

/*-----------------tableView下拉刷新--------------------*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (_isNeedPushDownRefresh || _isNeedPushUpRefresh) {
    if (_isLoading) return;
    preScrollViewContentOffsetY = scrollView.contentOffset.y;
    _isDragging = YES;
  }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (_isNeedPushDownRefresh && (_refreshDirection == PushDownRefresh)) {
    if (_isLoading) {
        // Update the content inset, good for section headers
      if (scrollView.contentOffset.y > 0)
        _contentTableView.contentInset = UIEdgeInsetsZero;
      else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
        _contentTableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } 
    else if (_isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
      [UIView beginAnimations:nil context:NULL];
      if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
          // User is scrolling above the header
        _refreshHeaderLabel.text = self.textRelease;
        [_refreshHeaderArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
      } else { // User is scrolling somewhere within the header
        _refreshHeaderLabel.text = self.textPullToDown;
        [_refreshHeaderArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
      }
      [UIView commitAnimations];
    }
  }
  
  int countSize = (int)floor(scrollView.contentSize.height/scrollView.frame.size.height);
  float scrollViewBeforeScrollContentOffsetY = scrollView.contentSize.height - scrollView.frame.size.height;
  if (_isNeedPushUpRefresh && countSize > 0 && (_refreshDirection == PushUpRefresh)) {
    if (_isLoading) {
        // Update the content inset, good for section headers
      if (scrollView.contentOffset.y < scrollViewBeforeScrollContentOffsetY)
        _contentTableView.contentInset = UIEdgeInsetsZero;
      else if (scrollView.contentOffset.y <= scrollViewBeforeScrollContentOffsetY+REFRESH_HEADER_HEIGHT)
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0,scrollView.contentOffset.y - scrollViewBeforeScrollContentOffsetY,  0);
    } 
    else if (_isDragging && scrollView.contentOffset.y > scrollViewBeforeScrollContentOffsetY) {
        // Update the arrow direction and label
      [UIView beginAnimations:nil context:NULL];
      if (scrollView.contentOffset.y > scrollViewBeforeScrollContentOffsetY+REFRESH_HEADER_HEIGHT) {
          // User is scrolling above the header
        _refreshFooterLabel.text = self.textRelease;
        [_refreshFooterArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
      } else { // User is scrolling somewhere within the header
        _refreshFooterLabel.text = self.textPullToUp;
        [_refreshFooterArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
      }
      [UIView commitAnimations];
    }
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (_isNeedPushUpRefresh || _isNeedPushDownRefresh){
    if (scrollView.contentOffset.y > 0){
      _refreshDirection = PushUpRefresh;
    }else{
      _refreshDirection = PushDownRefresh;
    }
    preScrollViewContentOffsetY = scrollView.contentOffset.y;
  }
  
  if (_isNeedPushDownRefresh && _refreshDirection == PushDownRefresh) {
    if (_isLoading) return;
    _isDragging = NO;
    
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
      [self startLoading];
    }
  }
  
  if (_isNeedPushUpRefresh && _refreshDirection == PushUpRefresh) {
    if (_isLoading) return;
    _isDragging = NO;
    int countSize = (int)floor(scrollView.contentSize.height/scrollView.frame.size.height);
    if (countSize > 0) {
      if ((!_isNeedSearch && scrollView.contentSize.height > PAGESIZE * CONTENTTABLEVIEW_CELL_HEIGHT) || 
          (_isNeedSearch && scrollView.contentSize.height > PAGESIZE * CONTENTTABLEVIEW_CELL_HEIGHT + SEARCHBAR_HEIGHT)) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height + REFRESH_HEADER_HEIGHT))
          [self startLoading];
      }
        //      if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height * countSize + REFRESH_HEADER_HEIGHT) )
      
    }
  }
  [_contentTableView reloadData];
}
/*-------------------------------------*/


#pragma mark --------- UISearchBarDelegate ------>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
  return YES;
}                     // return NO to not become first responder


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
  return YES;
}                       // return NO to not resign first responder

                   // called when text ends editing

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(didSearchWithSearchBar:)])
    [_searchDelegate didSearchWithSearchBar:searchBar];
}                     // called when keyboard search button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
  [_searchBar setText:@""];
  if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(cancelSearch)])
    [_searchDelegate cancelSearch];
}                    // called when cancel button pressed

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  if ([searchText isEqualToString:@""]) {
    if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(cancelSearch)])
      [_searchDelegate cancelSearch];
  }
}

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark =======	父类方法	 =======																																									
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark --------程序扩展	 --------
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration {
  [super relayoutForInterfaceOrientation:interfaceOrientation withDuration:duration];
  
//  _searchBar.hidden = YES;
  
  if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
    [self relayoutElementsForLandscapeInContentView];
  }
  else{
    [self relayoutElementsForPortraitInContentView];
  }
  [_contentTableView reloadData];
}

#pragma mark --------系统自带  --------

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setFrame:CGRectMake(0.0,0.0,MAINSCREEN_PORTRAIT_WIDTH,MAINSCREEN_PORTRAIT_HEIGHT)];
  [self.view setBackgroundColor:[UIColor clearColor]];
  [self loadHeaderView];
  [self loadContentTitleView];
  [self loadSearchBar]; 
  [self loadContentTableView];
  [self addPullToRefreshHeader];
  [self addPullToRefreshFooter];
}

- (void)viewDidDisappear:(BOOL)animated {
//  _searchBar.hidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
  if (_contentTitleView) _contentTitleView = nil;
  
  if (_contentTitleViewBackgroundView) _contentTitleViewBackgroundView = nil;
  if (_contentTableView) _contentTableView = nil;
  if (_leftTitleLabel) _leftTitleLabel = nil;
  if (_middleTitleLabel) _middleTitleLabel = nil;
  if (_rightTitleLabel) _rightTitleLabel = nil;
  
  if (_refreshHeaderView) _refreshHeaderView = nil;
  if (_refreshHeaderLabel) _refreshHeaderLabel = nil;
  if (_refreshHeaderArrow) _refreshHeaderArrow = nil;
  if (_refreshHeaderSpinner) _refreshHeaderSpinner = nil;
  if (_refreshFooterView) _refreshFooterView = nil;
  if (_refreshFooterLabel) _refreshFooterLabel = nil;
  if (_refreshFooterArrow)  _refreshFooterArrow = nil;
  if (_refreshFooterSpinner)  _refreshFooterSpinner = nil;

  if (_headerView) _headerView = nil;
  
  if (_searchBar) _searchBar = nil;
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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

@end
