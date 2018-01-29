//
//  GroupChoiceViewController.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "GroupChoiceViewController.h"
#import "UIControl+extension.h"
#import "Global.h"
#import "UIViewExt.h"
#import "HomeViewController.h"


#define kCellButtonTag    1000


@interface GroupChoiceViewController ()

@end

@implementation GroupChoiceViewController

- (id)initWithEnvironment:(BOOL)isInitialSystem {
    if (self = [super init]) {
        _isInitialSystem = isInitialSystem;
    }
    return self;
}

#pragma mark 私有方法 ---------->

/**
 *    @brief    添加navigationBar上面的返回会议信息按钮
 */
- (void)addRightBarButton {
    
    CGRect frame = CGRectMake(0, 0, 80.0, 35.0);
    UIImage *normalImage = [UIImage imageForName:@"btn_title_normal" type:@"png"];
    normalImage = [normalImage stretchableImageWithLeftCapWidth:24 topCapHeight:0];
    UIButton *logoutButton = [UIButton buttonWithFrame:frame
                                                 title:@"取消"
                                           normalImage:normalImage
                                        highlightImage:nil
                                         selectedImage:nil
                                                  font:SYSTEMFONT(16)
                                                target:self
                                                action:@selector(cancel:)
                                          controlEvent:UIControlEventTouchUpInside];
    [logoutButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    NSArray *rightButtonArray = [NSArray arrayWithObjects: logoutButton, nil];
    [self.navigationBar setRightSideButtonArray:rightButtonArray];
}


#pragma mark -
#pragma mark =======    事件处理  =======
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *    @brief    点击取消按钮响应事件，返回到登录界面
 *
 *    @param     sender     触发事件的控件
 */
- (void)cancel:(id)sender {
    HomeViewController *mainViewController = (HomeViewController *)[HomeViewController sharedMainViewController];
    [mainViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cellButtonClick:(id)sender {
    UIButton *button = sender;
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSLog(@"%@",cell);
    NSIndexPath *indexPath = [[self contentTableView] indexPathForCell:cell];
    if (_delegate && [_delegate respondsToSelector:@selector(groupChoiceViewController:didSelectGroup:)]) {
        Group *selectedGroup = [_groupsArray objectAtIndex:indexPath.row];
        NSLog(@"you choice row:%d",indexPath.row);
        [_delegate groupChoiceViewController:self didSelectGroup:selectedGroup];
    }
}



/**
 *    @brief    从数据库中预加载历史会议分组数据
 */
- (void)loadGroups {
    if (_groupsArray) {
        _groupsArray = nil;
    }
    _groupsArray = (NSMutableArray *)[Group arrayFromSqlite];
    if (ServerLogin == [Global loginStatus]) {
        //[Global showLoadingProgressViewWithText:@"正在更新组织机构\n请稍等..." window:self.view.window];
        [self performSelector:@selector(requestGroups) withObject:nil afterDelay:0.2];
    }
    [self performSelector:@selector(hideProgressView) withObject:nil afterDelay:0.2];
}

- (void)hideProgressView {
    //[Global hideProgressViewForType:none message:@"" afterDelay:TIPSSHOWTIME fromWindow:self.view.window];
    [[self contentTableView] reloadData];
}

//
- (void)requestGroups {
    
}


//

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationBar setTitle:@"公司选择"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadGroups];
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_isInitialSystem)
        [self addRightBarButton];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationBar.top = 20;
        self.contentView.top += 20;
    }
}


#pragma mark =======     tableViewDelegate & DataSource     =======

- (UIButton *)buttonForCellWithFrame:(CGRect)frame title:(NSString *)title {
    UIImage *image = [UIImage imageForName:@"groupChoice_bg" type:@"png"];
    UIButton *button = [UIButton buttonWithFrame:frame
                                           title:title normalImage:image
                                  highlightImage:nil
                                   selectedImage:nil
                                            font:BOLDSYSTEMFONT(24)
                                          target:self
                                          action:@selector(cellButtonClick:)
                                    controlEvent:UIControlEventTouchUpInside];
    [button setTitleColor:TITLE_AND_CONTENT_TEXTCOLOR forState:UIControlStateNormal];
    return button;
}


// 构造cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Group *group = [_groupsArray objectAtIndex:indexPath.row];
    CGFloat cellWidth = tableView.frame.size.width;
    CGFloat cellHeight = tableView.rowHeight;
    CGRect cellButtonFrame = CGRectMake((cellWidth - CELLBUTTON_WIDTH) / 2.0,  cellHeight - CELLBUTTON_Y, CELLBUTTON_WIDTH, CELLBUTTON_HEIGHT);
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIButton *cellButton = [self buttonForCellWithFrame:cellButtonFrame title:group.groupName];
        [cellButton setTag:kCellButtonTag];
        [cellButton setFrame:cellButtonFrame];
        [cell.contentView addSubview:cellButton];
        cell.backgroundColor = [UIColor clearColor];
    }
    else {
        UIButton *cellButton = (UIButton *)[cell.contentView viewWithTag:kCellButtonTag];
        [cellButton setFrame:cellButtonFrame];
        [cellButton setTitle:group.groupName forState:UIControlStateNormal];
    }
    return  cell;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark =======     代理实现     =======
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//code here...

#pragma mark TableViewDelegate & TableViewDataSource ------->
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_groupsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return CELL2_HEIGHT;
    }
    return CELL1_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


@end
