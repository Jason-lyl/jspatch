//
//  CarCellDataModel.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "CarCellDataModel.h"

@implementation CarCellDataModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSArray*)parseRespondData:(NSArray*)respondData{
    NSMutableArray *carsNewsList = [NSMutableArray array];
    for (NSDictionary *dic in respondData) {
        CarCellDataModel *model = [[CarCellDataModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [carsNewsList addObject:model];
    }
    return carsNewsList;
}
@end
