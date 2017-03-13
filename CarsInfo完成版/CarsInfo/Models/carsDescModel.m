//
//  carsDescModel.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "carsDescModel.h"

@implementation carsDescModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

+ (NSArray*)parseRespondData:(NSArray*)respondData{
    NSMutableArray *carsNewsList = [NSMutableArray array];
    for (NSDictionary *dic in respondData) {
        carsDescModel *model = [[carsDescModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [carsNewsList addObject:model];
    }
    return carsNewsList;
}

@end
