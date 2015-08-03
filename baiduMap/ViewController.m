//
//  ViewController.m
//  baiduMap
//
//  Created by yi on 15/7/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ZYQuickControl.h"
#import "MapViewController.h"
#import "SearchViewController.h"
#import "PinViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_itemArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *btn1 = [self.view addSystemButtonWithFrame:CGRectMake(100, 100, 100, 50) title:@"定位" action:^(UIButton *button) {
//        MapViewController *mapVC = [[MapViewController alloc] init];
//        [self.navigationController pushViewController:mapVC animated:YES];
//    }];
//    
//    UIButton *btn2 = [self.view addImageButtonWithFrame:CGRectMake(100, 200, 150, 50) title:@"地址编码反编码" background:nil action:^(UIButton *button) {
//        SearchViewController *searVC = [[SearchViewController alloc] init];
//        [self.navigationController pushViewController:searVC animated:YES];
//    }];
    
    self.title = @"百度地图SDK使用";
    _itemArray = @[@"定位",@"地址编码和反编码",@"大头针气泡功能"];
    
    
    [self createTableView];
    
    
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"itemcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _itemArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MapViewController *mapVC = [[MapViewController alloc] init];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
    else if (indexPath.row == 1)
    {
        SearchViewController *searchVC = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        PinViewController *pinVC = [[PinViewController alloc] init];
        [self.navigationController pushViewController:pinVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
