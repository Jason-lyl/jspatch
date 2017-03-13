//
//  SettingViewController.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "SettingViewController.h"
#import "StartPageViewController.h"
#import "HotAppTableViewController.h"


@interface SettingViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cachLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    
}


- (IBAction)clearCach:(id)sender {
    //NSLog(@"buttonClick");
    NSInteger tmpSize = [[SDImageCache sharedImageCache] getSize];
    [[SDImageCache sharedImageCache] clearDisk];//清除硬盘的
    NSString *clearCacheName = tmpSize > 1024 ? [NSString stringWithFormat:@"正在清理缓存(%.2fM)",tmpSize/1024.0/1024.0]:@"暂时还不需要清理缓存哟";
    NSString *message = [NSString stringWithFormat:@"%@",clearCacheName];
    [MMProgressHUD showWithTitle:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MMProgressHUD dismiss];
    });
    
}
- (IBAction)startPage:(id)sender {
    StartPageViewController *startVC = [[StartPageViewController alloc] init];
    [self.navigationController pushViewController:startVC animated:YES];
}

- (IBAction)share:(id)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5606a5f9e0f55ac8570036da"
                                      shareText:@"1509 IOS 高级开发工程师 测试一下"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,nil]
                                       delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        NSLog(@"分享成功");
    }
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
