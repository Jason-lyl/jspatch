//
//  DownloadViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UIWebView * view1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44)];
    view1.scalesPageToFit = YES;
    
    [view1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.str]]];
    [self.view addSubview:view1];
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
