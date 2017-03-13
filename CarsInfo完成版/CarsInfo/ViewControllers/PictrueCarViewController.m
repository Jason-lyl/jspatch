//
//  PictrueCarViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "PictrueCarViewController.h"

@interface PictrueCarViewController ()<UIScrollViewDelegate>
{
    NSMutableArray * array;
    UIScrollView *_scrollView;
    UILabel *label;
    NSMutableArray *_iamgeViewArray;
    UIButton *_button;
    
}
@end

@implementation PictrueCarViewController
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    self.title = @"图片";
    array = [[NSMutableArray alloc] init];
    _iamgeViewArray = [NSMutableArray array];
    [self setRequest];
    [self createRightItemBtn];
}
-(void)setRequest{
    NSString *url = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/downEventAlbumPhotoList.do?albumId=%@",self.URL];
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:url success:^(id responsData) {
        for (NSDictionary *dic in responsData) {
            NSString *str = dic[@"bigImagePath"];
            [array addObject:str];
        }
         [self makeScrollView];
        
    } falied:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求数据" message:@"请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }];
}
-(void)makeScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.contentSize = CGSizeMake(kScreenWidth*array.count, kScreenHeight - 64 - 49 - 44);
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    
    [_iamgeViewArray removeAllObjects];
    
    for (int i = 0; i < array.count; i++) {
        CGFloat imageY = (kScreenHeight - kScreenWidth / 1.5 - 64 - 49 - 44)/2;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, imageY , kScreenWidth, kScreenWidth / 1.5)];
        [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]]];
        [_iamgeViewArray addObject:imageView];
        [_scrollView addSubview:imageView];
    }
    label = [[UILabel alloc] initWithFrame:CGRectMake(0,kScreenHeight - 64 - 49 - 44, kScreenWidth, 44)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = [NSString stringWithFormat:@"1/%ld",array.count];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    NSArray * arr = @[@"left",@"right"];
    for (int i = 0; i < 2; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 64, 44);
        CGFloat btn_X = (i==0)?label.center.x - 100 : label.center.x+100;
        btn.center = CGPointMake(btn_X,22);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_arrow.png",arr[i]]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        label.userInteractionEnabled = YES;
        btn.tag = 1+i;
        [label addSubview:btn];
    }
}
-(void)pressBtn:(UIButton *)button{
    
    int currentPageNew =(int)_scrollView.contentOffset.x/kScreenWidth;
    
    if (button.tag == 1) {
        if (currentPageNew > 0) {
            currentPageNew--;
        }
    } else  {
        if (currentPageNew < array.count-1) {
            currentPageNew ++;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(kScreenWidth * currentPageNew, 0);
        label.text = [NSString stringWithFormat:@"%d/%ld",currentPageNew + 1 ,array.count];
    } completion:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _button.userInteractionEnabled = YES;
    CGPoint point = scrollView.contentOffset;
    label.text = [NSString stringWithFormat:@"%d/%ld",(int)point.x/(int)kScreenWidth + 1,array.count];
}


#pragma mark - 保存图片

- (void)createRightItemBtn{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 80, 40);
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setTitle:@"保存图片" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)buttonClick{
    _button.userInteractionEnabled = NO;
    int index = _scrollView.contentOffset.x/kScreenWidth;
    UIImageView *imageView = _iamgeViewArray[index];
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        label1.bounds = CGRectMake(0, 0, 150, 40);
        label1.center = self.view.center;
        label1.backgroundColor = [UIColor blackColor];
        label1.text =@"成功保存到相册";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor whiteColor];
        [self.view addSubview:label1];
        [UIView animateWithDuration:5 animations:^{
            label1.alpha = 0;
        }];
    }else
    {
        _button.userInteractionEnabled = YES;
        message = [error description];
        NSLog(@"message is %@",message);
    }
    
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
