//
//  CarsInfoHelp.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "CarsInfoHelp.h"

@implementation CarsInfoHelp

+ (NSString*)dateFromTimeInterval:(NSTimeInterval)time
{
    //NSDate 代表时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    //NSDateFormatter 对时间进行格式化输出
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    //yyyy-MM-dd HH:mm:ss 年月日，时分秒
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}

@end
