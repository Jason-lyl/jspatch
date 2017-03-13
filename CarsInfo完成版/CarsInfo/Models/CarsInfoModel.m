//
//  CarsInfoModel.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "CarsInfoModel.h"

@implementation CarsInfoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSArray*)parseRespondData:(NSArray*)respondData
{
    NSMutableArray *carsNewsList = [NSMutableArray array];
    for (int index = 0; index < respondData.count - 1; index ++) {
        NSDictionary *dic = respondData[index];
        CarsInfoModel *model = [[CarsInfoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [carsNewsList addObject:model];
    }
    return carsNewsList;
}

@end
