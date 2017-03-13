//
//  NavigationView.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavigationView : UIView

@property (nonatomic,copy) void(^clickBlock)(int index);


@end
