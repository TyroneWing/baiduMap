//
//  ZYButton.m
//  FreeLimit
//
//  Created by qianfeng on 15/4/8.
//  Copyright (c) 2015年 ZhengYi. All rights reserved.
//

#import "ZYButton.h"

@implementation ZYButton

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btnClick:(UIButton *)button
{
    if (self.action) {
        self.action(self);
    }
}
@end
