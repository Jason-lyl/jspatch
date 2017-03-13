//
//  TypeCarDescViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "TypeCarDescViewController.h"
#import "carsDescModel.h"
#import "typeCarDescTableViewCell.h"

@interface TypeCarDescViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation TypeCarDescViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    [self createDataSource];
    self.tableView.frame = CGRectMake(0, 110, kScreenWidth, kScreenHeight - 49 - 64 - 110);
    [self.tableView registerNib:[UINib nibWithNibName:@"typeCarDescTableViewCell" bundle:nil] forCellReuseIdentifier:@"modelCarCellId"];
    
}
- (void)createDataSource{
    NSString *url = [NSString stringWithFormat:TypeCarDesc,self.URL];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"亲,正在拼命加载..."];
    
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:url success:^(id responsData) {
        
        [MMProgressHUD dismissWithSuccess:@"亲,终于加载完了🌹" ];
        
        [self.carImageView sd_setImageWithURL:[NSURL URLWithString:responsData[@"imagepath"]] placeholderImage:[UIImage imageNamed:@"default_pic.png"]];
        self.label1.text = [NSString stringWithFormat:@"级别:%@",responsData[@"levelName"]];
        self.label2.text = [NSString stringWithFormat:@"价格:%@-%@",responsData[@"minPrice"],responsData[@"maxPrice"]];
        self.label3.text = [NSString stringWithFormat:@"驱动方式:%@",responsData[@"drive"]];
        self.label4.text = [NSString stringWithFormat:@"保修:%@",responsData[@"guarantee"]];
        NSArray * arr = responsData[@"modelList"];
        self.dataSource = (NSMutableArray*)[carsDescModel parseRespondData:arr];
        
        [self.tableView reloadData];
        
    } falied:^(NSError *error) {
        [MMProgressHUD showWithTitle:@"亲,此车暂无数据"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MMProgressHUD dismiss];
            });
        
    }];
}

#pragma mark - UITableViewDelegateAndUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    typeCarDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"modelCarCellId" forIndexPath:indexPath];
    carsDescModel *model = self.dataSource[indexPath.row];
    cell.modelPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.modelPrice];
    cell.modelNamelabel.text = model.modelName;
    cell.modelDesclabel.text = [NSString stringWithFormat:@"%@工信部耗油%@L/百公里%@",model.transmission,model.fuelConsumption,model.levelName];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
