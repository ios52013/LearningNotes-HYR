//
//  UIControl+extension.m
//  PACDMS_ipad
//
//  Created by yangfeiyue on 7/21/11.
//  Copyright 2011 zbkc. All rights reserved.
//

#import "UIControl+extension.h"


@implementation UIControl_extension

@end


////////////////////////////////////////////////////////////////////////////
//     UIViewController extension
/////
@implementation UIViewController (extension)

- (void)relayoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withDuration:(NSTimeInterval)duration {
  
}
@end



////////////////////////////////////////////////////////////////////////////
//     UIButton extension
/////
@implementation UIButton (extension)
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
                              controlEvent:(UIControlEvents)controlEvent
{
	UIButton *button_f = [[UIButton alloc] initWithFrame:frame];
	[button_f setBackgroundColor:[UIColor clearColor]];
	if (title)
		[button_f setTitle:title forState:UIControlStateNormal];
	if (normalImage)
		[button_f setBackgroundImage:normalImage forState:UIControlStateNormal];
	if (highlightImage)
		[button_f setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
	if (selectedImage)
		[button_f setBackgroundImage:selectedImage forState:UIControlStateSelected];
	if (font)
		[button_f.titleLabel setFont:font];
	if (action && target)
		[button_f addTarget:target action:action forControlEvents:controlEvent];
	return button_f;
}


@end

////////////////////////////////////////////////////////////////////////////
//     UILabel extension
/////
@implementation UILabel (extension)

/**
 *	@brief	在size大小下，font字体的text自动调整高度大小
 *
 *	@param 	size 	label上文字的尺寸
 *	@param 	text 	label上显示的文字
 *	@param 	font 	label上面字体
 *
 *	@return	在参数指定环境下，自动适应的label高度
 */
+ (CGFloat)automaticHeightForLabelWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font {
  CGSize constraintSize = CGSizeMake(size.width, 2000.0f);
  CGSize realSize = [text sizeWithFont:font
                                       constrainedToSize:constraintSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
  CGFloat autoHeigth = MAX(realSize.height, size.height);
  return autoHeigth;
}


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
                             textColor:(UIColor *)textColor
{
	CGFloat height_f = [self automaticHeightForLabelWithSize:frame.size text:text font:font];
	UILabel *label_f = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height_f)];
	[label_f setText:text];
	[label_f setTextColor:textColor];
	[label_f setFont:font];
	[label_f setNumberOfLines:0];
	[label_f setTextAlignment:NSTextAlignmentCenter];
    // [label_f setBackgroundColor:[UIColor redColor]];
  [label_f setBackgroundColor:[UIColor clearColor]];
	return label_f;
}




@end


////////////////////////////////////////////////////////////////////////////
//     UITextField extension
/////

@implementation UITextField (extension)

@end

////////////////////////////////////////////////////////////////////////////
//     UIImage extension
/////

@implementation UIImage (extension)
/**
 *	@brief	通过imageName和type获取图片
 *
 *	@param 	imageName 	图片文件的名字
 *	@param 	type 	图片文件的后缀名
 *
 *	@return	获取的图片独享
 */
+ (UIImage *)imageForName:(NSString *)imageName type:(NSString *)type {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:type];
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

    
/**
 *	@brief	通过bundleName获取当前工程中资源路径下名称为imageName图片
 *
 *	@param 	imageName 	图片名称
 *	@param 	bundleName 	包名称
 *
 *	@return	图片对象    
 */
+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName {
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
	NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
	return [UIImage imageWithContentsOfFile:imagePath];
}


/**
 *	@brief	重新设置图片大小
 *
 *	@param 	image 	重置大小的图片对象
 *	@param 	reSize 	新的尺寸
 *
 *	@return	新尺寸的图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
	UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
	[image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
	UIImage *reSizeIamge = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return reSizeIamge;
}


@end 


@implementation NSString (extension)
/**
 *	@brief	获取字符串的byte大小
 *
 *	@param 	strtemp	需要获取byte大小的字符串
 *
 *	@return	字符串的byte大小  
 */
+  (int)getStringByte:(NSString*)strtemp {
  int strlength = 0;
  char* p = (char*)[strtemp cStringUsingEncoding:NSUTF8StringEncoding];
  for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUTF8StringEncoding]; i++) {
    if (*p) {
      p++;
      strlength++;
    }
    else {
      p++;
    }
  }
  return strlength;
}

/**
 *	@brief	获取字符串的byte数，一个汉字为3byte，一个字符为1byte。
 *
 *	@return	字符串的byte数
 */
- (NSUInteger)numberOfBytes {
  NSUInteger  num = 0;
  for (int i = 0; i < self.length; i++) {
    unichar uc = [self characterAtIndex:i];
    num += isascii(uc) ? 1 : 3;
  }
  return num;
}

/**
 *	@brief	获取字符串的前bound个byte的子串
 *
 *	@param 	bound	需要获取子串在源字符串的边界值
 *
 *	@return	源字符串的 (0, bound) byte范围内的子串
 */
- (NSString *)getMaxStringWithBound:(NSInteger)bound {
  if (bound <= 0) {
    return @"";
  }
  int size = 0;
  NSInteger length = 0;
  for (int i = 0; i < self.length; i++) {
    unichar uc = [self characterAtIndex:i];
    int judge = size + ((isascii(uc)) ? 1 : 2);
    if (judge > bound) {
      break;
    }
    else {
      size += isascii(uc) ? 1 : 2;
      length++;
    }
  }
  return [self substringWithRange:NSMakeRange(0, length)];
}

@end


@implementation NSArray (extension)

/**
 *	@brief	查找 object 对象在数组当前数组中的 index
 * 
 *	@param 	object 	待查找的对象
 *
 *	@param 	key  匹配特征，唯一标示对象的字符串，即对象的id
 *
 *	@return	object 在当前数组中的index，或者是NotFound（一个大数）
 */
- (NSUInteger)indexOfObject:(id)object withKey:(NSString *)key {
  BOOL (^ predicate)(id obj, NSUInteger idx, BOOL *stop);
  predicate = ^(id obj, NSUInteger idx, BOOL *stop) {
    return [[obj valueForKey:key] isEqualToString:[object valueForKey:key]];
  };
  return [self indexOfObjectPassingTest:predicate];
}


@end


