//
//  UIView+ZYQuickControl.h
//  FreeLimit
//
//  Created by qianfeng on 15/4/8.
//  Copyright (c) 2015年 ZhengYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYQuickControl)
//添加系统按钮  void (^action)(UIButton *button)
- (UIButton *) addSystemButtonWithFrame:(CGRect)frame title:(NSString *)title action:(void (^)(UIButton *button))action;

//添加图片按钮
- (UIButton *) addImageButtonWithFrame:(CGRect)frame title:(NSString *)title background:(NSString *)background action:(void (^)(UIButton *button))action;

//添加imageView
-(UIImageView *)addImageViewWithFrame:(CGRect)frame image:(NSString *)image;

//添加标签
- (UILabel *)addLabelWithFrame:(CGRect)frame text:(NSString *)text;

//添加文本输入框TextField

- (UILabel *)addTextFieldWithFrame:(CGRect)frame text:(NSString *)text;


@end
