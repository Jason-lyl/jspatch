//
//  typeCarTableViewCell.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "typeCarModel.h"

@interface typeCarTableViewCell : UITableViewCell

- (void)updateUseingTypeCarModel:(typeCarModel *)model;
@property (nonatomic) typeCarModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;

@end
