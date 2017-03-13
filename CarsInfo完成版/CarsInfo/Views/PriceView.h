//
//  PriceView.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,copy) void(^clickBlock)(id model);

-(void)setRequest;
-(void)createView;

@end
