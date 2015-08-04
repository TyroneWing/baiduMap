//
//  PinViewController.m
//  baiduMap
//
//  Created by yi on 15/7/31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "PinViewController.h"

#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件

#import "UIView+ZYQuickControl.h"
#import "MyBMKPointAnnotation.h"
#import "companyViewController.h"
#import "CompanyClass.h"


@interface PinViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService* _locService;
}
@end

@implementation PinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"大头针气泡功能";

    //实现功能:多个大头针，且气泡点击进入不同界面
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    //卫星地图
    //    [_mapView setMapType:BMKMapTypeSatellite];
//    [_mapView setTrafficEnabled:YES];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    _mapView.zoomLevel = 14;
    
//    //定位
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    
//    [_locService startUserLocationService];
//    
//    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//    _mapView.showsUserLocation = YES;//显示定位图层
//    //跟随模式
//    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
//    _mapView.showsUserLocation = YES;//显示定位图层
    
    //定制大头针
    
    MyBMKPointAnnotation* annotation = [[MyBMKPointAnnotation alloc]init];
    annotation.company = @"A工厂";
    annotation.companyAdress = @"A路6号";
    annotation.companyDescription = @"水污染：铅超标";
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.companyType = 1;
    [_mapView addAnnotation:annotation];
    
    MyBMKPointAnnotation* annotation2 = [[MyBMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = 39.925;
    coor2.longitude = 116.414;
    annotation2.company = @"B公司";
    annotation2.companyAdress = @"B路8号";
    annotation2.companyDescription = @"PH值异常";
    annotation2.companyType = 2;

    annotation2.coordinate = coor2;
    [_mapView addAnnotation:annotation2];
    
    MyBMKPointAnnotation* annotation3 = [[MyBMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor3;
    coor3.latitude = 39.905;
    coor3.longitude = 116.444;
    annotation3.company = @"C公司";
    annotation3.companyAdress = @"C路1号";
    annotation3.companyDescription = @"重金属含量超标";
    annotation3.companyType = 3;
    annotation3.coordinate = coor3;
    [_mapView addAnnotation:annotation3];
    
    MyBMKPointAnnotation* annotation4 = [[MyBMKPointAnnotation alloc]init];
    annotation4.company = @"D工厂";
    annotation4.companyAdress = @"D路6号";
    annotation4.companyDescription = @"水污染严重";
    CLLocationCoordinate2D coor4;
    coor4.latitude = 39.920;
    coor4.longitude = 116.413;
    annotation4.coordinate = coor4;
    annotation4.companyType = 1;
    [_mapView addAnnotation:annotation4];
    
}

- (void)selectAnnotation:(id <BMKAnnotation>)annotation animated:(BOOL)animated;
{
    animated = NO;
    NSLog(@"------------");
}


//-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.animatesDrop = YES;
//        newAnnotationView.annotation = annotation;
//        //这里我根据自己需要，继承了BMKPointAnnotation，添加了标注的类型等需要的信息
//        MyBMKPointAnnotation *tt = (MyBMKPointAnnotation *)annotation;
//        
//        //判断类别，需要添加不同类别，来赋予不同的标注图片
//        if (tt.profNumber == 100000) {
//            newAnnotationView.image = [UIImage imageNamed:@"ic_map_mode_category_merchants_normal.png"];
//        }else if (tt.profNumber == 100001){
//            
//        }
//        //设定popView的高度，根据是否含有缩略图
//        double popViewH = 60;
//        if (annotation.subtitle == nil) {
//            popViewH = 38;
//        }
//        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, popViewH)];
//        popView.backgroundColor = [UIColor whiteColor];
//        [popView.layer setMasksToBounds:YES];
//        [popView.layer setCornerRadius:3.0];
//        popView.alpha = 0.9;
//        //        //设置弹出气泡图片
//        //        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:tt.imgPath]];
//        //        image.frame = CGRectMake(0, 160, 50, 60);
//        //        [popView addSubview:image];
//        
//        //自定义气泡的内容，添加子控件在popView上
//        UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, 160, 30)];
//        driverName.text = annotation.title;
//        driverName.numberOfLines = 0;
//        driverName.backgroundColor = [UIColor clearColor];
//        driverName.font = [UIFont systemFontOfSize:15];
//        driverName.textColor = [UIColor blackColor];
//        driverName.textAlignment = NSTextAlignmentLeft;
//        [popView addSubview:driverName];
//        
//        UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(8, 30, 180, 30)];
//        carName.text = annotation.subtitle;
//        carName.backgroundColor = [UIColor clearColor];
//        carName.font = [UIFont systemFontOfSize:11];
//        carName.textColor = [UIColor lightGrayColor];
//        carName.textAlignment = NSTextAlignmentLeft;
//        [popView addSubview:carName];
//        
//        if (annotation.subtitle != nil) {
//            UIButton *searchBn = [[UIButton alloc]initWithFrame:CGRectMake(170, 0, 50, 60)];
//            [searchBn setTitle:@"查看路线" forState:UIControlStateNormal];
//            searchBn.backgroundColor = mainColor;
//            searchBn.titleLabel.numberOfLines = 0;
//            [searchBn addTarget:self action:@selector(searchLine)];
//            [popView addSubview:searchBn];
//        }
//        
//        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
//        pView.frame = CGRectMake(0, 0, ScreenWidth-100, popViewH);
//        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = nil;
//        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = pView;
//        return newAnnotationView;
//    }
//    return nil;
//}
//

//定制大头针，并且重绘制气泡
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.paopaoView = nil;
        
        MyBMKPointAnnotation *MyAnnotation = (MyBMKPointAnnotation *)annotation;
        UIView *_areaPaoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 80)];
        _areaPaoView.backgroundColor=[UIColor whiteColor];
        _areaPaoView.alpha = 0.9;
        
        [_areaPaoView addLabelWithFrame:CGRectMake(0, 0, 80, 30) text:MyAnnotation.company];
        
        [_areaPaoView addLabelWithFrame:CGRectMake(80, 0, 100, 30) text:MyAnnotation.companyAdress];
        
        [_areaPaoView addLabelWithFrame:CGRectMake(00, 40, 150, 30) text:MyAnnotation.companyDescription];
        
        [_areaPaoView addSystemButtonWithFrame:CGRectMake(140, 0, 40, 30) title:@"查看" action:^(UIButton *button) {
            
            NSLog(@"%@:%@",MyAnnotation.company,MyAnnotation.companyDescription);
            
            companyViewController *comVC = [[companyViewController alloc] init];
            comVC.company = MyAnnotation.company;
            [self.navigationController pushViewController:comVC animated:YES];
        }];
        
        
        BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc] initWithCustomView:_areaPaoView];
        newAnnotationView.paopaoView = paopao;
        
        if (MyAnnotation.companyType == 1) {
//            newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
             newAnnotationView.image = [UIImage imageNamed:@"type1.png"];   //把大头针换成别的图片
        }
        else if (MyAnnotation.companyType == 2)
        {
//            newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
             newAnnotationView.image = [UIImage imageNamed:@"type2.png"];   //把大头针换成别的图片
        }
        else
        {
//            newAnnotationView.pinColor = BMKPinAnnotationColorRed;
             newAnnotationView.image = [UIImage imageNamed:@"type3.png"];   //把大头针换成别的图片
        }
        

        return newAnnotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"大头针点击");

    NSLog(@"点击之前lon%f,lat%f",_mapView.centerCoordinate.longitude,_mapView.centerCoordinate.latitude);
    
    _mapView.centerCoordinate = view.annotation.coordinate;
    
    NSLog(@"点击之后lon：%f,lat%f",_mapView.centerCoordinate.longitude,_mapView.centerCoordinate.latitude);

}


// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
//    view.paopaoView.hidden = YES;

}


//// 根据anntation生成对应的View
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    NSString *AnnotationViewID = [NSString stringWithFormat:@"renameMark%d",i];
//    
//    newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//    // 设置颜色
//    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
//    // 从天上掉下效果
//    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
//    // 设置可拖拽
//    ((BMKPinAnnotationView*)newAnnotation).draggable = YES;
//    //设置大头针图标
//    ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"zhaohuoche"];
//    
//    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
//    //设置弹出气泡图片
//    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi"]];
//    image.frame = CGRectMake(0, 0, 100, 60);
//    [popView addSubview:image];
//    //自定义显示的内容
//    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 100, 20)];
//    driverName.text = @"张XX师傅";
//    driverName.backgroundColor = [UIColor clearColor];
//    driverName.font = [UIFont systemFontOfSize:14];
//    driverName.textColor = [UIColor whiteColor];
//    driverName.textAlignment = NSTextAlignmentCenter;
//    [popView addSubview:driverName];
//    
//    UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 20)];
//    carName.text = @"京A123456";
//    carName.backgroundColor = [UIColor clearColor];
//    carName.font = [UIFont systemFontOfSize:14];
//    carName.textColor = [UIColor whiteColor];
//    carName.textAlignment = NSTextAlignmentCenter;
//    [popView addSubview:carName];
//    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
//    pView.frame = CGRectMake(0, 0, 100, 60);
//    ((BMKPinAnnotationView*)newAnnotation).paopaoView = nil;
//    ((BMKPinAnnotationView*)newAnnotation).paopaoView = pView;
//    i++;
//    return newAnnotation;
//    
//}


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    // NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    
}


/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
