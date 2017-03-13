//
//  ConditionCarViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "ConditionCarViewController.h"
#import "TypeCarViewController.h"
#import "PriceView.h"
#import "CarTypeView.h"
#import "CarPriceModel.h"
#import "CarCellDataModel.h"
#import "carCellTableViewCell.h"

@interface ConditionCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic)PriceView *priceView;
@property (nonatomic)CarTypeView *carTypeView;
@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSMutableArray *dataSource;
@property (nonatomic)CarPriceModel *model;

@end

@implementation ConditionCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self createNavBar];
    [self createButton];
    [self createTableView];
}
- (void)initData{
    self.model = [[CarPriceModel alloc]init];
    self.dataSource = [NSMutableArray array];
}

- (void)createButton{
    NSArray *titleArray = @[@"按价格选车",@"按车型选车"];
    for (int index = 0; index < titleArray.count; index ++) {
        UIButton *button = [CustomViewFactory createButton:CGRectMake(index *kScreenWidth * 0.5 , 0, kScreenWidth * 0.5, 30) title:titleArray[index] backgourdImage:[UIImage imageNamed:@"select.png"]];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        [button addTarget:self  action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        [self.view addSubview:button];
        button.tag =  index + 100;
    }
}

- (void)pressBtn:(UIButton *)button{
    if (button.tag == 100) {
        if (!self.priceView) {
            self.priceView = [[PriceView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 64 - 30 - 49)];
            [self.view addSubview:self.priceView];
            __weak typeof (self) myself = self;
            [self.priceView setClickBlock:^(id model){
                myself.model = model;
                myself.PriceUrl = myself.model.price;
                [myself.view insertSubview:myself.priceView atIndex:0];
                UIButton *button = (UIButton *)[myself.view viewWithTag:100];
                [button setTitle:myself.model.name forState:UIControlStateNormal];
                
                [myself setRequest];
            }];
        }
        [self.view bringSubviewToFront:self.priceView];
    }
    if (button.tag == 101) {
        if (!self.carTypeView) {
            
            __weak typeof (self) myself = self;
            self.carTypeView = [[CarTypeView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 64 - 30 - 49)];
            [self.view addSubview:self.carTypeView];
            [self.carTypeView setClickBlock:^(id model){
                myself.model = model;
                myself.TypeUrl = myself.model.level;
                [myself.view insertSubview:myself.carTypeView atIndex:0];
                UIButton *button = (UIButton *)[myself.view viewWithTag:101];
                [button setTitle:myself.model.name forState:UIControlStateNormal];
                [myself setRequest];
            }];
        }
        [self.view bringSubviewToFront:self.carTypeView];
    }
}

-(void)setRequest{
    if ([self.PriceUrl length] == 0 && [self.TypeUrl length] != 0) {
        self.myUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/downSeriesInfo.do?priceInterval=&level=%@",self.TypeUrl];
        [self startRequest];
    }
    if ([self.PriceUrl length] != 0 && [self.TypeUrl length] == 0) {
        self.myUrl =[NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/downSeriesInfo.do?priceInterval=%@&level=",self.PriceUrl];
        [self startRequest];
    }
    if ([self.PriceUrl length]!= 0 && [self.TypeUrl length] !=0) {
        self.myUrl =[NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/downSeriesInfo.do?priceInterval=%@&level=%@",self.PriceUrl,self.TypeUrl];
        [self startRequest];
    }
}

- (void)startRequest{
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"亲,正在拼命加载..."];
    
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:self.myUrl success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"亲,终于加载完了🌹" ];
        [self.dataSource removeAllObjects];
        self.dataSource = (NSMutableArray *)[CarCellDataModel parseRespondData:responsData];
        if (!self.dataSource.count) {
            [MMProgressHUD showWithTitle:@"未获取到对应数据"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MMProgressHUD dismiss];
            });
        }
        [self.tableView reloadData];
        
    } falied:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"亲,加载失败了😢"];
    }];
}

- (void)createNavBar{
    CGFloat btnW =kScreenWidth / 2;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.btnArray = [[NSMutableArray alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"cellbar.png"];
    [view addSubview:imageView];
    NSArray *arr = @[@"ppxc",@"tjxc"];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i* btnW - 15, 0, btnW, 44);
        btn.tag = i+1;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@.png",arr[i]]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@_press.png",arr[i]]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        [self.btnArray addObject:btn];
        if (btn.tag == 2) {
            btn.selected = YES;
        }
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}
-(void)buttonClick:(UIButton *)btn {
    if (btn.selected) {
        btn.userInteractionEnabled = NO;
    }
    if (btn.tag == 1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        btn.selected = NO;
    }
}


- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 64 - 30 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 70;
    
    UINib *nib = [UINib nibWithNibName:@"carCellTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"carCellId"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    carCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCellId" forIndexPath:indexPath];
    CarCellDataModel *model = self.dataSource[indexPath.row];
    [cell.imagePathView sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"default_pic.png"]];
    cell.seriesNameLabel.text = model.seriesName;
    cell.guidePriceLabel.text = model.guidePrice;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarCellDataModel *model = self.dataSource[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"model" object:model];
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
