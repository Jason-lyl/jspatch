//
//  InfoCarsTableViewCell.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "InfoCarsTableViewCell.h"


@implementation InfoCarsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)updateUseingModel:(CarsInfoModel*)model atIndexPath:(NSIndexPath*)indexPath{
    self.model = model;
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:model.coverpic] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    self.titleLabel.text = model.title;
    self.tiemLabel.text = [CarsInfoHelp dateFromTimeInterval:([model.time doubleValue]/1000)];
    self.descLabel.text = model.subhead;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
