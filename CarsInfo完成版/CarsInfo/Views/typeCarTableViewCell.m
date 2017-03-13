//
//  typeCarTableViewCell.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "typeCarTableViewCell.h"

@implementation typeCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)updateUseingTypeCarModel:(typeCarModel *)model{
    self.model =model;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_pic.png" ]];
    self.brandNameLabel.text = model.brandName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
