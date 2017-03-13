//
//  BeautifePictrueView.h
//  CarsInfo
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautifePictrueView :UIView<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,retain) UICollectionView *collectionView;
@property (nonatomic,retain) NSMutableArray * dataArr;
@property (nonatomic,copy) void(^clickBlock)(id str);
-(void)setRequest;

@end
