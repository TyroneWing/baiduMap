//
//  MyBMKPointAnnotation.h
//  
//
//  Created by yi on 15/8/1.
//
//

#import <BaiduMapAPI/BMKPointAnnotation.h>

@interface MyBMKPointAnnotation : BMKPointAnnotation

@property (nonatomic,retain) NSString *company;

@property (nonatomic,retain) NSString *companyAdress;

@property (nonatomic,retain) NSString *companyDescription;

@property (nonatomic,assign) int companyType;


@end
