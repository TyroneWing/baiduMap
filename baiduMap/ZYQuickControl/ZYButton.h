//
//  ZYButton.h
//  FreeLimit
//
//  Created by qianfeng on 15/4/8.
//  Copyright (c) 2015年 ZhengYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYButton : UIButton

//点击后执行Block
//void action(UIButton *button)
//注意：block属性修饰符必须是copy
@property(copy,nonatomic) void (^action)(UIButton *button);

@end
