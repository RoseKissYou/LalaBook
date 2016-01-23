//
//  SearchFilesViewController.m
//  N+
//
//  Created by hy1 on 16/1/18.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "SearchFilesViewController.h"
#import "AAASearchTool.h"
#import "AAASearchParam.h"
#import "CommonCell.h"

@interface SearchFilesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *firstArr;
@property (nonatomic,strong) NSArray *secondArr;

@end

@implementation SearchFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求档案查询的数据
    [self getFilesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFilesData{
    AAASearchParam *param = [AAASearchParam sharedAAASearchParam];
    param.tbname = @"档案查询";
    
    [[AAASearchTool sharedAAASearchTool] getPresentDailyData:param Success:^(NSArray *result1, NSArray *result2) {
        self.firstArr = result1;
        self.secondArr = result2;
        
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        ;
    }];

}

#pragma mark - UITableView - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.firstArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.secondArr[section * 2]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.secondArr;
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCell" forIndexPath:indexPath];
    NSArray *arr1 = arr[indexPath.section * 2];
    NSArray *arr2 = arr[indexPath.section * 2 + 1];
    cell.keyLabel.text = arr1[indexPath.row];
    cell.valueLabel.text = arr2[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.firstArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.firstArr.count - 1) {
        return 20.;
    }else{
        return 1.;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.;
}

@end
