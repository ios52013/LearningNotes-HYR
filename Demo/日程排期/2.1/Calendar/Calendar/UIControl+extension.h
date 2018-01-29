//
//  UIControl+extension.h
//  PACDMS_ipad
//
//  Created by yangfeiyue on 7/21/11.
//  Copyright 2011 zbkc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *	@brief	UI 控件 api 扩展方法
 */
@interface UIControl_extension : NSObject {
}

@end



////////////////////////////////////////////////////////////////////////////
//     UIViewController extension
/////
/**
 *	@brief	UIViewController 扩展方法
 */
@interface  UIViewController (extension)
- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration;
@end


////////////////////////////////////////////////////////////////////////////
//     UIButton extension
/////

/**
 *	@brief	UIButton 扩展方法
 */
@interface UIButton	(extension)

/**
 *	@brief	构造button的工厂方法
 *
 *	@param 	frame 	button的尺寸和位置
 *	@param 	title 	button的标题
 *	@param 	normalImage 	正常状态下的背景图片
 *	@param 	highlightImage 	高亮的背景图片
 *	@param 	selectedImage 	选择后的背景图片
 *	@param 	font 	字体
 *	@param 	target 	目标对象
 *	@param 	action 	响应方法
 *	@param 	controlEvent 	响应事件
 *
 *	@return	工厂方法构建的autorelease的button对象
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                                          title:(NSString *)title
                              normalImage:(UIImage *)normalImage
                           highlightImage:(UIImage *)highlightImage
                           selectedImage:(UIImage *)selectedImage
                                           font:(UIFont *)font
                                        target:(id)target
                                         action:(SEL)action
                               controlEvent:(UIControlEvents)controlEvent;

@end


////////////////////////////////////////////////////////////////////////////
//     UILabel extension
/////

/**
 *	@brief	UILabel 扩展方法
 */
@interface UILabel (extension)

/**
 *	@brief	 构造label的工厂方法
 *
 *	@param 	frame 	label的尺寸和位置
 *	@param 	text 	label显示的文字
 *	@param 	font 	label上面的梯子
 *	@param 	textColor 	label上面文字的颜色
 *
 *	@return	定制的label对象
 */
+ (UILabel *)labelWithFrame:(CGRect)frame 
                                     text:(NSString *)text 
                                     font:(UIFont *)font 
                             textColor:(UIColor *)textColor;

/**
 *	@brief	在size大小下，font字体的text自动调整高度大小
 *
 *	@param 	size 	label上文字的尺寸
 *	@param 	text 	label上显示的文字
 *	@param 	font 	label上面字体
 *
 *	@return	在参数指定环境下，自动适应的label高度
 */
+ (CGFloat)automaticHeightForLabelWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font;

@end

////////////////////////////////////////////////////////////////////////////
//     UITextField extension
/////

@interface UITextField (extension)



@end


////////////////////////////////////////////////////////////////////////////
//     UIImage extension
/////

/**
 *	@brief	UIImage 扩展方法
 */
@interface UIImage (extension)

/**
 *	@brief	通过imageName和type获取图片
 *
 *	@param 	imageName 	图片文件的名字
 *	@param 	type 	图片文件的后缀名
 *
 *	@return	获取的图片独享
 */
+ (UIImage *)imageForName:(NSString *)imageName type:(NSString *)type;

/**
 *	@brief	通过bundleName获取当前工程中资源路径下名称为imageName图片
 *
 *	@param 	imageName 	图片名称
 *	@param 	bundleName 	包名称
 *
 *	@return	图片对象    
 */
+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName;

/**
 *	@brief	重新设置图片大小
 *
 *	@param 	image 	重置大小的图片对象
 *	@param 	reSize 	新的尺寸
 *
 *	@return	新尺寸的图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

@end


/**
 *	@brief	NSString 扩展方法
 */

@interface NSString (extension)
/**
 *	@brief	获取字符串的byte大小
 *
 *	@param 	strtemp	需要获取byte大小的字符串
 *
 *	@return	字符串的byte大小
 */
+  (int)getStringByte:(NSString*)strtemp;

/**
 *	@brief	获取字符串的byte数，一个汉字为2byte，一个字符为1byte。
 *
 *	@return	字符串的byte数
 */
- (NSUInteger)numberOfBytes;

/**
 *	@brief	获取字符串的前bound个byte的子串
 *
 *	@param 	bound	需要获取子串在源字符串的边界值
 *
 *	@return	源字符串的 (0, bound) byte范围内的子串
 */
- (NSString *)getMaxStringWithBound:(NSInteger)bound;
@end

/**
 *	@brief	NSArray 扩展方法
 */


#define ConferenceID  @"cid"
#define AgendaID        @"aid"
#define MaterialID      @"mid"
#define CouncilID         @"councilId"
#define DirecotoryID   @"did"

@interface NSArray (extension)

/**
 *	@brief	查找 object 对象在数组当前数组中的 index
 * 
 *	@param 	object 	待查找的对象
 *
 *	@param 	key  匹配特征，唯一标示对象的字符串，即对象的id
 *
 *	@return	object 在当前数组中的index，或者是NotFound（一个大数）
 */
- (NSUInteger)indexOfObject:(id)object withKey:(NSString *)key;

@end
