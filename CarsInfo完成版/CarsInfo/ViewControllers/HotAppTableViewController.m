//
//  HotAppTableViewController.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "HotAppTableViewController.h"
#import "HotAppModel.h"
#import "HotViewTableViewCell.h"
#import "DownloadViewController.h"

@interface HotAppTableViewController ()
@property(nonatomic)NSMutableArray *dataArr;

@end

@implementation HotAppTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"HotViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"hotCellId"];
   self.navigationItem.title = @"热门推荐";
    self.dataArr = [NSMutableArray array];
    [self setRequest];  
}

- (void)setRequest{
    NSString *url = @"http://api.tool.chexun.com/mobile/downMobileClientProgramInfo.do?type=2";
    [[NetDataEngine sharedInstance] requestInfoCarsFrom:url success:^(id responsData) {
        for (NSDictionary *dic in responsData) {
            HotAppModel *model =[[HotAppModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        
    } falied:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求数据" message:@"请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count - 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCellId" forIndexPath:indexPath];
    HotAppModel *model = self.dataArr[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.introdLabel.text = model.introduction;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotAppModel *model = self.dataArr[indexPath.row];
    DownloadViewController *downVC = [[DownloadViewController alloc] init];
    downVC.str = model.link;
    [self.navigationController pushViewController:downVC animated:YES]; 
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
