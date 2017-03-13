//
//  pictureView.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pictureView : UIView

@property (nonatomic,copy) void(^clickBlock)(int index);


@end
