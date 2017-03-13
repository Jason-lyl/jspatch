//
//  CarCellDataModel.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.

#import <Foundation/Foundation.h>

@interface CarCellDataModel : NSObject

+ (NSArray*)parseRespondData:(NSArray*)respondData;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *defect;
@property (nonatomic, copy) NSString *displacements;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *wapURL;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, copy) NSString *recommendSort;
@property (nonatomic, copy) NSString *merit;
@property (nonatomic, copy) NSString *combinedConsumptions;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *guidePriceFor4S;
@property (nonatomic, copy) NSString *guidePrice;
@property (nonatomic, copy) NSString *seriesName;
@property (nonatomic, copy) NSString *levelName;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *seriesId;
@property (nonatomic, copy) NSString *english;


@end
