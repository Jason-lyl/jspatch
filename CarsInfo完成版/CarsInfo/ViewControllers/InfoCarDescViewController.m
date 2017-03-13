//
//  InfoCarDescViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "InfoCarDescViewController.h"
#import "CarsInfoModel.h"
#import <WebKit/WebKit.h>

@interface InfoCarDescViewController ()<WKNavigationDelegate>

@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIProgressView *progressView;

@end

@implementation InfoCarDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBar];
    [self createWebView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)customNavBar{
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
}
- (void)goBack
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createWebView{
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:self.myUrl ];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self createProgressView];
}

- (void)createProgressView {
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
}

#pragma mark - webViewDelegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.progressView.progress = self.webView.estimatedProgress;
    if(self.progressView.progress == 1.0) {
        self.progressView.hidden = YES;
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
