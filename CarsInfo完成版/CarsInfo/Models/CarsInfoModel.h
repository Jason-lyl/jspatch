//
//  CarsInfoModel.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarsInfoModel : NSObject

+ (NSArray*)parseRespondData:(NSArray*)respondData;

@property (nonatomic,copy) NSString *coverpic;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *njson;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *subhead;



@end
