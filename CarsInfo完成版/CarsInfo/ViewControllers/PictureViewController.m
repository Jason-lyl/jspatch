//
//  PictureViewController.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureView.h"
#import "BeautifePictrueView.h"
#import "PictrueCarCell.h"
#import "PictureModel.h"
#import "BeautyPicViewController.h"
#import "PictrueCarViewController.h"

@interface PictureViewController ()

{
    UIView * view;
    BeautifePictrueView *_beautifView;
}

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeView];
    self.tableView.separatorStyle = NO;
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    [self.view addSubview:view];
    [view addSubview:_beautifView.collectionView];
}
-(void)makeView{
    
    _beautifView = [[BeautifePictrueView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    __weak PictureViewController *bea = self;
    [_beautifView setClickBlock:^(id model) {
        BeautyPicViewController *bpvc = [[BeautyPicViewController alloc] init];
        PictureModel *picModel = model;
        bpvc.myUrl = picModel.albumId;
        [bea.navigationController pushViewController:bpvc animated:YES];
    }];
    
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
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"PictrueCarCell" bundle:nil] forCellWithReuseIdentifier:@"ID"];
    

    pictureView *pv = [[pictureView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pv];
    [pv setClickBlock:^(int index){
        if (index == 1) {
            [_beautifView setRequest];
            [self.view addSubview:view];
            _collectionView.hidden = YES;
            [view addSubview:_beautifView.collectionView];
            [_beautifView.collectionView reloadData];
        }
        if (index == 2) {
            _collectionView.hidden = NO;
            [view removeFromSuperview];
            [self setRequest];
        }
    }];
}

-(void)setRequest{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"正在拼命加载..."];

    [[NetDataEngine sharedInstance] requestInfoCarsFrom:@"http://api.tool.chexun.com/mobile/downEventAlbumList.do?type=0" success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"恭喜下载数据成功"];
        for (NSDictionary *dic in responsData) {
            PictureModel *model = [[PictureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [_collectionView reloadData];
    } falied:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"数据下载失败"];
    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictrueCarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    PictureModel *model = self.dataArr[indexPath.row];
    [cell.ablumView sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
    cell.picNumLabel.text = [NSString stringWithFormat:@"共%@张图片",model.picNumber];
    cell.ablumnLabel.text = model.albumName;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureModel *model = self.dataArr[indexPath.row];
    PictrueCarViewController *pvc = [[PictrueCarViewController alloc] init];
    pvc.URL = model.albumId;
    [self.navigationController pushViewController:pvc animated:YES];
}



- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
