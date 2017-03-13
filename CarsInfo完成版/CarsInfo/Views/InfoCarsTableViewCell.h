//
//  InfoCarsTableViewCell.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarsInfoModel.h"

@interface InfoCarsTableViewCell : UITableViewCell

@property(nonatomic)CarsInfoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiemLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (void)updateUseingModel:(CarsInfoModel*)model atIndexPath:(NSIndexPath*)indexPath;

@end
