//
//  InfoViewController.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "InfoViewController.h"
#import "CarsInfoModel.h"
#import "InfoCarsTableViewCell.h"
#import "NavigationView.h"
#import "InfoCarDescViewController.h"
#import "JHRefresh.h"

@interface InfoViewController ()
@property(nonatomic)int page;
@property(nonatomic)NSString *url;
@property (nonatomic,copy)NSString *navTitle;
@property(nonatomic)BOOL isRefreshing;
@property(nonatomic)BOOL isLoadingMore;

@end

@implementation InfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.navTitle = @"新闻";
    [self createRefreshHeadView];
    [self createRefreshFootView];
if (self.page == 1) {
        self.url = [NSString stringWithFormat:kMainNews,self.page,self.page];
        [self fetchAppData];
    }
    [self createNavBtn];
    [self registTableViewCell];
}

- (void)initData{

    self.page = 1;
    
    
}
- (void)createRefreshHeadView
{
    __weak typeof(self)weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [weakSelf initData];
        weakSelf.isRefreshing = YES;
        [weakSelf fetchAppDataFromServer];
    }];
}

- (void)createRefreshFootView
{
    __weak typeof(self)weakSelf = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page++;
        weakSelf.isLoadingMore = YES;
        [weakSelf fetchAppDataFromServer];
    }];
}

- (void)endRefreshing
{
    if (self.isRefreshing) {
        self.isRefreshing  = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.tableView footerEndRefreshing];
    }
}


- (void)createNavBtn{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"celltopbar@2x.png"] forBarMetrics:UIBarMetricsDefault];
    NavigationView *nav= [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nav];
    [nav setClickBlock:^(int index){
        if (index== 1) {
            self.navTitle = @"新闻";
            [self.dataSourceArray removeAllObjects];
            self.page = 1;
            [self fetchAppData];
        }
        if (index == 2) {
            self.navTitle = @"导购";
            [self.dataSourceArray removeAllObjects];
            self.page = 1;
            [self fetchAppData];
            
        }
        if (index ==3) {
            self.navTitle = @"评测";
            [self.dataSourceArray removeAllObjects];
            self.page = 1;
            [self fetchAppData];
        }
        
    }];
}
- (NSString *)composeRequestUrl{
    if ([self.navTitle isEqualToString:@"新闻"]) {
        self.url = [NSString stringWithFormat:kMainNews,self.page,self.page];
        NSLog(@"%d",self.page);
    }
    if ([self.navTitle isEqualToString:@"导购"]) {
        self.url =[NSString stringWithFormat:KMainShoping_Url,self.page,self.page];
    }
    if ([self.navTitle isEqualToString:@"评测"]) {
        self.url = [NSString stringWithFormat:KMainEvaluation_Url,self.page,self.page];
    }
    return self.url;
}

- (void)registTableViewCell{
    UINib *nib = [UINib nibWithNibName:@"InfoCarsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InfoCellId"];
}



#pragma mark -
#pragma mark fetch data
- (void)fetchAppData{
    //首先从本地缓存中读取，如果没有缓存或者缓存实效，再从网络上抓取数据
    if (![self fetchAppDataFromLocal]) {
        [self fetchAppDataFromServer];
    }
}
- (BOOL)fetchAppDataFromLocal
{
    
    return NO;
}

- (void)fetchAppDataFromServer{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    
    NSString *url = [self composeRequestUrl];
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:url success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"恭喜下载数据成功" ];
        [self parseRespondData:responsData];
        [self.tableView reloadData];
        [self endRefreshing];
    } falied:^(NSError *error) {
     [MMProgressHUD dismissWithError:@"数据下载失败"];
        [self endRefreshing];
    }];

}

- (void)parseRespondData:(id)responsData
{
    if (self.page == 1) {
        [self.dataSourceArray removeAllObjects];
        self.dataSourceArray = (NSMutableArray*)[CarsInfoModel parseRespondData:(NSArray*)responsData];
    }else{
        [self.dataSourceArray addObjectsFromArray:[CarsInfoModel parseRespondData:(NSArray*)responsData]];
    }
}



#pragma mark - 代理 数据源

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InfoCarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCellId" forIndexPath:indexPath];
    CarsInfoModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    [cell updateUseingModel:model atIndexPath:indexPath]
    ;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarsInfoModel *model = self.dataSourceArray[indexPath.row];
    InfoCarDescViewController *desc = [[InfoCarDescViewController alloc] init];
    desc.navigationItem.title = self.navTitle;
    desc.myUrl = model.url;
    [self.navigationController pushViewController:desc animated:YES];
    self.tabBarController.tabBar.hidden = YES;
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
