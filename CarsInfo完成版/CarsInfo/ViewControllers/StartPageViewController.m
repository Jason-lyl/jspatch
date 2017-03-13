//
//  StartPageViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "StartPageViewController.h"

@interface StartPageViewController ()

{
    NSMutableArray *_btnArray;
}

@end

@implementation StartPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeView];
    [self startPage];
}

- (void)startPage{
     NSInteger index = [[[NSUserDefaults standardUserDefaults]objectForKey:@"startPage"] integerValue];
    for (UIButton * button in _btnArray) {
        button.selected = NO;
        if (button.tag == index) {
            button.selected = YES;
        }
    }
}

- (void)makeView{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bigbg.png"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    _btnArray = [[NSMutableArray alloc] init];
    NSArray * arr = @[@"zx",@"cx",@"pic"];
    int k =0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j< 2-i; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat paddingX = (kScreenWidth - 90 * 2)/3.0;
            CGFloat paddingY = (kScreenHeight - 64 - 49 - 110 * 2 - 50)/3.0;
            btn.frame = CGRectMake(paddingX + (90 + paddingX) * j , paddingY + 64 + (110 + paddingY) * i, 90, 110);
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@.png",arr[k]]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@_press.png",arr[k]]] forState:UIControlStateSelected];
            btn.tag =k++;
            [_btnArray addObject:btn];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (btn.tag == 0) {
                btn.selected = YES;
            }
            [imageView addSubview:btn];
        }
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnX = (kScreenWidth - 100)/2.0;
    CGFloat btnY = (kScreenHeight - 50 - 100);
    button.frame = CGRectMake(btnX, btnY, 100, 50);
    [button addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_confirm.png"]] forState:UIControlStateNormal];
    [imageView addSubview:button];
    button.tag = 5;
}
-(void)pressBtn:(UIButton *)button{
    for (UIButton * button in _btnArray) {
        button.selected = NO;
    }
    button.selected = YES;
}
- (void)ClickBtn:(UIButton *)btn{
    for (UIButton *button in _btnArray) {
        if (button.selected == YES) {
            NSString *startPage = [NSString stringWithFormat:@"%ld",button.tag];
            [[NSUserDefaults standardUserDefaults] setObject:startPage forKey:@"startPage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
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

