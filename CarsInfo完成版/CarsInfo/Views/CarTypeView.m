//
//  CarTypeView.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "CarTypeView.h"
#import "CarPriceModel.h"

@implementation CarTypeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self maekeView];
        
    }
    return self;
}
-(void)maekeView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49 - 30)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    [self addSubview:self.tableView];
    [self setRequest];
}
-(void)setRequest{
    self.dataSources = [[NSMutableArray alloc] init];
    NSString * path1 = [[NSBundle mainBundle] pathForResource:@"CarModel" ofType:@"plist"];
    NSArray * arr1 = [[NSArray alloc] initWithContentsOfFile:path1];
    for (NSDictionary * dic in arr1) {
        CarPriceModel * carM = [[CarPriceModel alloc] init];
        carM.name = dic[@"name"];
        carM.level = dic[@"level"];
        [self.dataSources addObject:carM];
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    CarPriceModel *model = self.dataSources[indexPath.row];
    
    cell.textLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarPriceModel *model = self.dataSources[indexPath.row];
    if (self.clickBlock) {
        self.clickBlock(model);
    }
}
-(void)createView{
}

@end
