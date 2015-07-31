//
//  SearchViewController.m
//  baiduMap
//
//  Created by yi on 15/7/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "SearchViewController.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件
#import "UIView+ZYQuickControl.h"

@interface SearchViewController ()<BMKGeoCodeSearchDelegate,BMKMapViewDelegate,UITextFieldDelegate>
{
    BMKMapView *_mapView;
    
    //search
    BMKGeoCodeSearch* _geocodesearch;
    
    //地址输入框：输入地址查询经纬度
    UITextField *_addrText;
    
    //纬度输入框
    UITextField *_latitudeText;
    //经度输入框
    UITextField *_longitudeText;

}


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"地址编码和反编码功能";

    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    //卫星地图
    //    [_mapView setMapType:BMKMapTypeSatellite];
    [_mapView setTrafficEnabled:YES];
    [self.view addSubview:_mapView];
    
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    //地址输入框
    _addrText = [[UITextField alloc] initWithFrame:CGRectMake(20, 64+10, 200, 30)];
    _addrText.backgroundColor = [UIColor lightGrayColor];
    _addrText.delegate = self;
    _addrText.text = @"广州塔";
    [backView addSubview:_addrText];
    
    //地址编码按钮
    [backView addSystemButtonWithFrame:CGRectMake(250, 64+10, 60, 30) title:@"地址编码" action:^(UIButton *button) {
        BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        //    geocodeSearchOption.city= _cityText.text;
        geocodeSearchOption.address = _addrText.text;
        BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
        [_addrText resignFirstResponder];
    }];

    //地址反编码：根据经纬度找出相应的地点
    //经度输入框
    _longitudeText = [[UITextField alloc] initWithFrame:CGRectMake(20, 64+10+40, 100, 30)];
    _longitudeText.backgroundColor = [UIColor lightGrayColor];
    _longitudeText.delegate = self;
    _longitudeText.placeholder = @"经度";
    [backView addSubview:_longitudeText];
    
    //纬度输入框
    _latitudeText = [[UITextField alloc] initWithFrame:CGRectMake(130, 64+10+40, 100, 30)];
    _latitudeText.backgroundColor = [UIColor lightGrayColor];
    _latitudeText.delegate = self;
    _latitudeText.placeholder = @"纬度";
    [backView addSubview:_latitudeText];
    
    
    //地址反编码按钮
    [backView addSystemButtonWithFrame:CGRectMake(240, 64+10+40, 130, 30) title:@"地址反编码" action:^(UIButton *button) {
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        if (_longitudeText.text != nil && _latitudeText.text != nil) {
            pt = (CLLocationCoordinate2D){[_latitudeText.text floatValue], [_longitudeText.text floatValue]};
        }
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
    }];
    
}


//地址编码搜索结果，系统自动调用
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
       
        NSLog(@"地址编码结果：%@",result.address);
        
        //添加大头针
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        
        //地图中心点
        _mapView.centerCoordinate = result.location;
        _mapView.zoomLevel = 19.00;
        
        //CLLocationCoordinate2D//经纬度
        
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"正向地理编码";
        
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.longitude,item.coordinate.latitude];
        NSLog(@"%@",showmeg);
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}

//地址反编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
    
    NSLog(@"%@",result.poiList);

    NSLog(@"详细地址信息：%@--%@--%@--%@--%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber);
}


//-(void)onClickReverseGeocode
//{
//    isGeoSearch = false;
//    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
//    if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
//        pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
//    }
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;
//    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
//    
//}

//-(void)onClickGeocode
//{
////    isGeoSearch = true;
//    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
////    geocodeSearchOption.city= _cityText.text;
//    geocodeSearchOption.address = _addrText.text;
//    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"geo检索发送失败");
//    }
//    
//}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
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
