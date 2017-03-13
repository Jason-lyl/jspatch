//
//  PictureViewController.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "BaseViewController.h"

@interface PictureViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,retain) NSMutableArray * dataArr;

@property (nonatomic,retain) UICollectionView *collectionView;
@end
