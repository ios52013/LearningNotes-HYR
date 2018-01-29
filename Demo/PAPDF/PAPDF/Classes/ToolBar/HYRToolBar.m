//
//  HYRToolBar.m
//  PAPDF
//
//  Created by 钟文成(外包) on 2018/1/23.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "HYRToolBar.h"

@implementation HYRToolBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        [self addTitleLabel];
        [self setAutoresizesSubviews:YES];
    }
    return self;
}


/**
 *    @brief    加载标题栏
 */
- (void)addTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10)];
    
#warning todo - setMinimumScaleFactor isEqu???
    //[_titleLabel setMinimumFontSize:10];
    [_titleLabel setMinimumScaleFactor:10.0/[UIFont labelFontSize]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setText:@""];
    [self addSubview:_titleLabel];
}


/**
 *    @brief    设置标题文字
 *
 *    @param     title     标题文字
 */
- (void)setTitle:(NSString *)title {
    CGRect titleLabelFrame = _titleLabel.frame;
    CGSize constraintSize = CGSizeMake(titleLabelFrame.size.width, self.bounds.size.height - 10);
    //  CGSize realSize = [title sizeWithFont:_titleLabel.font
    //                                      constrainedToSize:constraintSize
    //                                      lineBreakMode:UILineBreakModeWordWrap];
    CGFloat actualFont = [[_titleLabel font] pointSize];
    CGSize realSize = [title sizeWithFont:_titleLabel.font minFontSize:10 actualFontSize:&actualFont forWidth:constraintSize.width lineBreakMode:NSLineBreakByWordWrapping];
    
//    CGSize realSize = [title sizeWithFont:_titleLabel.font minFontSize:10 actualFontSize:&actualFont forWidth:constraintSize.width lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat autoHeigth = MAX(realSize.height, self.bounds.size.height);
    titleLabelFrame.size.height = autoHeigth;
    [_titleLabel setFrame:titleLabelFrame];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setAdjustsFontSizeToFitWidth:YES];
    [_titleLabel setText:title];
}



#pragma mark ----     公有接口  ----
/**
 *    @brief    设置背景图片
 *
 *    @param     image     背景图片
 *
 */
- (void)setBackgroundImage:(UIImage *)image {
    [self.layer setContents:(id)[image CGImage]];
}


/**
 *    @brief    设置左侧按钮数组
 *
 *    @param     array     将要加载到左侧的按钮数组
 */
- (void)setLeftSideButtonArray:(NSArray *)array {
    
    _leftSideButtonArray = array ;
    [self addLeftButtons];
}


/**
 *    @brief    设置右侧按钮数组
 *
 *    @param     array     将要加载到右侧的按钮数组
 */
- (void)setRightSideButtonArray:(NSArray *)array {
    
    _rightSideButtonArray = array;
    [self addRightButtons];
}




#pragma mark ----     私有接口      ----
/**
 *    @brief    加载左侧的按钮
 */
- (void)addLeftButtons {
    if (_leftSideButtonArray && [_leftSideButtonArray count] > 0) {
        int leftCount_f = [_leftSideButtonArray count];
        for (int i = 0; i < leftCount_f; i++) {
            UIButton *button_f = [_leftSideButtonArray objectAtIndex:i];
            CGFloat x_preEnd = 0;
            if (i > 0) {
                UIButton *pre_button_f = [_leftSideButtonArray objectAtIndex:i - 1];
                x_preEnd = pre_button_f.frame.origin.x + pre_button_f.bounds.size.width;
            }
            CGFloat height_f = MIN(button_f.bounds.size.height, self.bounds.size.height - BUTTON_MARGIN * 2);
            [button_f setFrame:CGRectMake(BUTTON_MARGIN + x_preEnd,
                                          (self.bounds.size.height - button_f.bounds.size.height) / 2,
                                          button_f.bounds.size.width,
                                          height_f)];
            [self addSubview:button_f];
        }
    }
}


/**
 *    @brief    加载右侧的按钮
 */
- (void)addRightButtons {
    if (_rightSideButtonArray && [_rightSideButtonArray count] > 0) {
        int rightCount_f = [_rightSideButtonArray count];
        for (int i = rightCount_f - 1; i >= 0 ; i--) {
            UIButton *button_f = [_rightSideButtonArray objectAtIndex:i];
            CGFloat x_next = self.bounds.size.width;
            if (i < rightCount_f - 1) {
                UIButton *next_button_f = [_rightSideButtonArray objectAtIndex:i + 1];
                x_next = next_button_f.frame.origin.x;
            }
            CGFloat height_f = MIN(button_f.bounds.size.height, self.bounds.size.height - BUTTON_MARGIN * 2);
            [button_f setFrame:CGRectMake(x_next - button_f.bounds.size.width - BUTTON_MARGIN,
                                          (self.bounds.size.height - button_f.bounds.size.height) / 2,
                                          button_f.bounds.size.width,
                                          height_f)];
            [self addSubview:button_f];
        }
    }
}


/**
 *    @brief    加载toolbar上面的按钮
 */
- (void)addButtons {
    [self addLeftButtons];
    [self addRightButtons];
}



@end
