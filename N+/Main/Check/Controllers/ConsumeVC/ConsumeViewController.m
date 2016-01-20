//
//  ConsumeViewController.m
//  N+
//
//  Created by hy1 on 16/1/20.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "ConsumeViewController.h"

#import "OverTAndCons.h"
#import "NSString+SubstringBySpace.h"

#import "AAASearchAPI.h"

@interface ConsumeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,assign) NSInteger count;
@end

@implementation ConsumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    AAASearchParam *param = [AAASearchParam sharedAAASearchParam];
    param.entname  = @"百得电器";
    param.tbname = @"消费查询";
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
    OverTAndCons *cell = [tableView dequeueReusableCellWithIdentifier:@"OCCell" forIndexPath:indexPath];
    NSArray *arr = self.arr[indexPath.row];
    cell.timeLabel.text = [NSString getSubstring:arr[4]];
    cell.startLabel.text = arr[5];
    cell.endLabel.text = arr[6];
    cell.durlingLabel.text = arr[7];
    cell.typeLabel.text = arr[8];
    return cell;
}
@end
