//
//  RootViewController.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic,strong)NSArray *controllersArray;
@property (nonatomic,strong)NSArray *tabBarImageArray;

@end

@implementation RootViewController

- (id)init{
    if (self = [super init]) {
        [self createTabInfoArray];
        [self createContentViewControllers];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)createTabInfoArray{
    self.controllersArray = [NSArray arrayWithObjects:@"InfoViewController",@"TypeCarViewController",@"PictureViewController",@"SettingViewController", nil];
    self.tabBarImageArray = [NSArray arrayWithObjects:@"zxicon",@"cxicon",@"picicon",@"moreicon",nil];
    
}

- (void)createContentViewControllers{
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int index = 0; index < self.controllersArray.count; index++) {
        
        UIViewController *viewController = [[NSClassFromString(self.controllersArray[index]) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu_%@.png",self.tabBarImageArray[index]]];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"menu_%@_press.png",self.tabBarImageArray[index]]];
        
        //更换图片渲染模式
        nav.tabBarItem.selectedImage = [nav.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [viewControllers addObject:nav];
    }
    //设置tabBar的背景颜色
    CGRect frame = CGRectMake(0.0, 0, kScreenWidth, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor blackColor]];
    [self.tabBar insertSubview:v atIndex:0];
    
    self.viewControllers = viewControllers;
    NSInteger index = [[[NSUserDefaults standardUserDefaults]objectForKey:@"startPage"] integerValue];
    self.selectedViewController = [self.viewControllers objectAtIndex:index];
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
