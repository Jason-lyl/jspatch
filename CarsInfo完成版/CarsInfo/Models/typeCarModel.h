//
//  typeCarModel.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface typeCarModel : NSObject

+ (NSArray*)parseRespondData:(NSArray*)respondData;

@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *letter;
@property (nonatomic, copy) NSString *wapURL;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, copy) NSString *english;

@end
