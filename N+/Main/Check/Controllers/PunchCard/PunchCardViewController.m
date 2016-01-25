//
//  PunchCardViewController.m
//  N+
//
//  Created by hy1 on 16/1/20.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "PunchCardViewController.h"
#import "PunchCardCell.h"

#import "NSString+SubstringBySpace.h"

#import "AAASearchAPI.h"

@interface PunchCardViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,assign) NSInteger count;



@end

@implementation PunchCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    AAASearchParam *param = [AAASearchParam sharedAAASearchParam];
    param.entname  = @"百得电器";
    param.tbname = @"刷卡查询";
    param.empcode = @"111714";
    param.autoid = @"201510";
    
    [[AAASearchTool sharedAAASearchTool] getPresentDailyDataMore:[AAASearchParam sharedAAASearchParam] Success:^(NSArray *result1, NSArray *result2) {
        self.arr = result2;
        self.count = result2.count;
        NSLog(@"%@",result2);
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PunchCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PunchCCell" forIndexPath:indexPath];
    NSArray *arr = self.arr[indexPath.row];
    cell.timeLabel.text = [NSString getSubstring:arr[4]];
    cell.atTimeLabel.text = arr[5];
    cell.nummerLabel.text = arr[6];

    return cell;
}

@end
