//
//  CustomViewFactory.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "CustomViewFactory.h"

@implementation CustomViewFactory

+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title backgourdImage:(UIImage*)backgroundImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

+ (UILabel*)createLabel:(CGRect)frame title:(NSString*)title color:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    UIColor *labelColor = (color == nil ? [UIColor blackColor]:color);
    label.textColor = labelColor;
    UIFont  *labelFont = (font == nil ? [UIFont systemFontOfSize:17] : font);
    label.font = labelFont;
    label.textAlignment = alignment;
    return label;
}

@end
