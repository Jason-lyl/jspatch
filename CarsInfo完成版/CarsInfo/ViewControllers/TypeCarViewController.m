//
//  TypeCarViewController.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "TypeCarViewController.h"
#import "typeCarModel.h"
#import "typeCarTableViewCell.h"
#import "ConditionCarViewController.h"
#import "CarCellDataModel.h"
#import "carCellTableViewCell.h"
#import "TypeCarDescViewController.h"

@interface TypeCarViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic)UITableView *carCellTableView;
@property(nonatomic,strong)NSMutableArray *carCellDataArray;
@property(nonatomic)UIScrollView *scrollView;
@end

@implementation TypeCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49);
    [self fetchLOgoData];
    [self createNavBar];
    [self registTableViewCell];
    [self createcarCellTableView];
    self.carCellTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(model:) name:@"model" object:nil];
}
-(void)model:(NSNotification *)notification{
    CarCellDataModel *model = [notification object];
    [self enterDesc:model];
    
    
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
        btn.frame = CGRectMake(i* btnW + 15, 0, btnW, 44);
        btn.tag = i+1;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@.png",arr[i]]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@_press.png",arr[i]]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        [self.btnArray addObject:btn];
        if (btn.tag == 1) {
            btn.selected = YES;
        }
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}
-(void)buttonClick:(UIButton *)btn {
    if (btn.selected) {
        btn.userInteractionEnabled = NO;
    }
    if (btn.tag == 2) {
        ConditionCarViewController *conVC = [[ConditionCarViewController alloc] init];
        [self.navigationController pushViewController:conVC animated:NO];
        btn.selected = NO;
    }
}


- (void)registTableViewCell{
    UINib *nib = [UINib nibWithNibName:@"typeCarTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"typeCarCellId"];
}

- (void)fetchLOgoData{
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
        
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:ModelCar_Url success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"恭喜下载数据成功" ];
        [self.dataSourceArray removeAllObjects];
        self.dataSourceArray = (NSMutableArray*)[typeCarModel parseRespondData:(NSArray*)responsData];
        [self.tableView reloadData];
    } falied:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"数据下载失败"];
    }];
        
}

- (void)fetchCarCellData:(NSString *)Id{
    NSString *url = [NSString stringWithFormat:PinPaiCar_Url,Id];
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:url success:^(id responsData) {
        [self.carCellDataArray removeAllObjects];
        self.carCellDataArray = (NSMutableArray*)[CarCellDataModel parseRespondData :(NSArray*)responsData];
        if (!self.carCellDataArray.count) {
            [MMProgressHUD showWithTitle:@"亲，此车暂未收录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MMProgressHUD dismiss];
            });
        }
        [self.carCellTableView reloadData];
    } falied:^(NSError *error) {
        
    }];
}
- (void)createcarCellTableView{
    
    self.carCellTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight- 64 - 49) style:UITableViewStylePlain];
    self.carCellTableView.delegate = self;
    self.carCellTableView.dataSource = self;
    [self.view addSubview:self.carCellTableView];
    self.carCellTableView.rowHeight = 70;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.carCellTableView addGestureRecognizer:swipe];
    
}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.carCellTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight- 64 - 49 );
    [UIView commitAnimations];
}


#pragma mark - 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.dataSourceArray.count;
    }else{
        return self.carCellDataArray.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        typeCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeCarCellId" forIndexPath:indexPath];
        typeCarModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
        [cell updateUseingTypeCarModel:model];
        return cell;
    }else{
        carCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCellId"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"carCellTableViewCell" owner:self options:nil] lastObject];
        }
        CarCellDataModel *model = self.carCellDataArray[indexPath.row];
        [cell.imagePathView sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"default_pic.png"]];
        cell.seriesNameLabel.text = model.seriesName;
        cell.guidePriceLabel.text = model.guidePrice;
        UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, 20)];
        
        self.carCellTableView.tableHeaderView = view1;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, 20)];
        [view1 addSubview:label];
        label.text = model.brandName;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor brownColor];
        label.textColor = [UIColor whiteColor];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.carCellTableView.frame = CGRectMake(80, 0, kScreenWidth, kScreenHeight - 64 - 49);
        [UIView commitAnimations];
         typeCarModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
        NSString * str = model.brandId;
        [self fetchCarCellData:str];
    }
    if (tableView == self.carCellTableView) {
        CarCellDataModel *model = self.carCellDataArray[indexPath.row];
        [self enterDesc:model];
        
    }
}
- (void)enterDesc:(CarCellDataModel *)model{
    TypeCarDescViewController*mdvc = [[TypeCarDescViewController alloc] init];
    mdvc.URL = model.seriesId;
    mdvc.name = model.seriesName;
    mdvc.serId = model.seriesId;
    [self.navigationController pushViewController:mdvc animated:YES];
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
