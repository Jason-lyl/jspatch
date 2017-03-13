//
//  carCellTableViewCell.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagePathView;
@property (weak, nonatomic) IBOutlet UILabel *seriesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guidePriceLabel;

@end
