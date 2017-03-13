//
//  typeCarModel.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "typeCarModel.h"

@implementation typeCarModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSArray*)parseRespondData:(NSArray*)respondData{
    NSMutableArray *carsNewsList = [NSMutableArray array];
    for (NSDictionary *dic in respondData) {
        typeCarModel *model = [[typeCarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [carsNewsList addObject:model];
    }
    return carsNewsList;
}
@end
