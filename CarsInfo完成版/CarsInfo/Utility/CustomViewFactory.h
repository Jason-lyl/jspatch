//
//  CustomViewFactory.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomViewFactory : NSObject

+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title backgourdImage:(UIImage*)backgroundImage;

+ (UILabel*)createLabel:(CGRect)frame title:(NSString*)title color:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment;

@end
