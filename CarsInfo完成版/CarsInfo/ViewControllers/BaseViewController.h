//
//  BaseViewController.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSMutableArray *dataSourceArray;
@end
