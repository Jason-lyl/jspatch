//
//  NetDataEngine.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SuccessBlockType) (id responsData);
typedef void(^FailedBlockType)(NSError *error);

@interface NetDataEngine : NSObject

+ (instancetype)sharedInstance;

- (void)requestInfoCarsFrom:(NSString*)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock;
@end
