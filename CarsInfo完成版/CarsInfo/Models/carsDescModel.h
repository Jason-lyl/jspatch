//
//  carsDescModel.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface carsDescModel : NSObject
+ (NSArray*)parseRespondData:(NSArray*)respondData;
@property (nonatomic,copy) NSString *modelId;
@property (nonatomic,copy) NSString *modelName;
@property (nonatomic,copy) NSString *levelName;
@property (nonatomic,copy) NSString *modelPrice;
@property (nonatomic,copy) NSString *guarantee;
@property (nonatomic,copy) NSString *transmission;
@property (nonatomic,copy) NSString *fuelConsumption;
@property (nonatomic,copy) NSString *imagePath;

@end
