//
//  AppDelegate.h
//  baiduMap
//
//  Created by yi on 15/7/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     BMKMapManager* _mapManager; 
}

@property (strong, nonatomic) UIWindow *window;


@end

