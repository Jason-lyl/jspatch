//
//  CarTypeView.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTypeView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *dataSources;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,copy) void(^clickBlock)(id model);
-(void)setRequest;
-(void)createView;


@end
