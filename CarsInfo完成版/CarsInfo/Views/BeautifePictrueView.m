//
//  BeautifePictrueView.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "BeautifePictrueView.h"
#import "PictureModel.h"
#import "PictrueCell.h"

@implementation BeautifePictrueView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
        
    }
    return self;
}
-(void)makeView{
    self.dataArr = [[NSMutableArray alloc] init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemSizeW = kScreenWidth  * 0.5  - 45;
    CGFloat itemSizeH = itemSizeW ;
    CGFloat padding = (kScreenWidth - 2 * itemSizeW)/3;
    layout.itemSize = CGSizeMake(itemSizeW, itemSizeH);
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    layout.minimumInteritemSpacing = padding;
    layout.minimumLineSpacing = padding;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"PictrueCell" bundle:nil] forCellWithReuseIdentifier:@"ID"];
    [self setRequest];
}

-(void)setRequest{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"正在拼命加载..."];
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:@"http://api.tool.chexun.com/mobile/downEventAlbumList.do?type=3" success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"恭喜下载数据成功" ];
        
        for (NSDictionary *dic in responsData) {
            PictureModel *model = [[PictureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [self.collectionView reloadData];
        
    } falied:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"数据下载失败"];
    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictrueCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    PictureModel *model = self.dataArr[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
    cell.picNumberLabel.text = [NSString stringWithFormat:@"共%@张图片",model.picNumber];
    cell.ablumNameLabel.text = model.albumName;
    return cell;
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureModel *model = self.dataArr[indexPath.row];
    if (self.clickBlock) {
        self.clickBlock(model);
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
