//
//  UIView+ZYQuickControl.m
//  FreeLimit
//
//  Created by qianfeng on 15/4/8.
//  Copyright (c) 2015年 ZhengYi. All rights reserved.
//

#import "UIView+ZYQuickControl.h"
#import "ZYButton.h"
@implementation UIView (ZYQuickControl)
//添加系统按钮  void (^action)(UIButton *button)
- (UIButton *) addSystemButtonWithFrame:(CGRect)frame title:(NSString *)title action:(void (^)(UIButton *button))action
{
    ZYButton *button = [ZYButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.action = action;
    [self addSubview:button];
    return button;
}

//添加图片按钮
- (UIButton *) addImageButtonWithFrame:(CGRect)frame title:(NSString *)title background:(NSString *)background action:(void (^)(UIButton *button))action
{
    ZYButton *button = [ZYButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:background] forState:UIControlStateNormal];
    button.action = action;
    [self addSubview:button];
    return button;
}

//添加imageView
-(UIImageView *)addImageViewWithFrame:(CGRect)frame image:(NSString *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    return imageView;
}

//添加标签
- (UILabel *)addLabelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    [self addSubview:label];
    return label;
}

@end
