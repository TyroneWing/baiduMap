//
//  AppDelegate.m
//  baiduMap
//
//  Created by yi on 15/7/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件

#import "ViewController.h"
#import "MapViewController.h"


//MapviewController  定位功能
//SearchViewController  地址编码和地址反编码
//PinViewController 大头针功能




/*
 百度地图SDK接入使用：
 1.在 TARGETS->Build Phases-> Link Binary With Libaries中点击“+”按钮，在弹出的窗口中点击“Add Other”按钮，选择BaiduMapAPI.framework文件添加到工程中(注:1.静态库中采用ObjectC++实现，因此需要您保证您工程中至少有一个.mm后缀的源文件(您可以将任意一个.m后缀的文件改名为.mm)，或者在工程属性中指定编译方式，即将Xcode的Project -> Edit Active Target -> Build -> GCC4.2 - Language -> Compile Sources As设置为"Objective-C++";2.百度的BaiduMapAPI.framework分为模拟器和真机，注意选择使用)
 
 2.添加framework：在Xcode的Project -> Active Target ->Build Phases ->Link Binary With Libraries，添加 CoreLocation.framework、QuartzCore.framework、OpenGLES.framework、SystemConfiguration.framework、CoreGraphics.framework、Security.framework
 
 3.在TARGETS->Build Settings->Other Linker Flags 中添加-ObjC
 
 4.选中工程名，在右键菜单中选择Add Files to “工程名”…，从BaiduMapAPI.framework||Resources文件中选择mapapi.bundle文件，并勾选“Copy items if needed”复选框，单击“Add”按钮，将资源文件添加到工程中。

 5.引入头文件
    #import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
    #import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件
 
 6.Xcode6.4 需要添加UIKit.framework 框架
 
 
 
 
 */



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    //百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"SvcGp3GvxajE00sHeHQiGvtn"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // Add the navigation controller's view to the window and display.
    [self.window makeKeyAndVisible];

//    MapViewController *mapVC = [[MapViewController alloc] init];
//    self.window.rootViewController = mapVC;
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = naviVC;
    
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
