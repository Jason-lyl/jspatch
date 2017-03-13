//
//  PriceView.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "PriceView.h"
#import "CarPriceModel.h"

@implementation PriceView

- (id)initWithFrame:(CGRect)frame

{
    if (self = [super initWithFrame:frame]) {
        [self makeView];
        
    }
    return self;
}
-(void)makeView{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49 - 30) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = 40;
    [self addSubview:self.table];
    [self setRequest];
}

-(void)setRequest{
    
    self.dataArray = [[NSMutableArray alloc] init];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"CarPrice" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:path];
    for (NSDictionary *dict in arr){
        CarPriceModel *model = [[CarPriceModel alloc] init];
        model.name = dict[@"name"];
        model.price = dict[@"price"];
        [self.dataArray addObject:model];
    }
    
    [self.table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Id"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Id"];
    }
    CarPriceModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarPriceModel *model = self.dataArray[indexPath.row];
    if (self.clickBlock) {
        
        self.clickBlock(model);
    }
    
}
-(void)createView{
    
    
}


@end
