//
//  LeaveTableViewController.m
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "LeaveTableViewController.h"
#import "LeaveCell.h"
#import "AAASearchAPI.h"

#import "NSString+SubstringBySpace.h"

@interface LeaveTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign,nonatomic) NSInteger count;

@property (strong,nonatomic) NSArray *arr;

@end

@implementation LeaveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AAASearchParam *param = [AAASearchParam sharedAAASearchParam];
    param.entname  = @"百得电器";
    param.tbname = @"请假查询";
    param.empcode = @"111714";
    param.autoid = @"201508";
    
    [[AAASearchTool sharedAAASearchTool] getPresentDailyDataMore:[AAASearchParam sharedAAASearchParam] Success:^(NSArray *result1, NSArray *result2) {
        self.arr = result2;
        self.count = result2.count;

        [self.tableView reloadData];
        
    } Failure:^(NSError *error) {
        ;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeaveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCell" forIndexPath:indexPath];
    NSArray *array = (NSArray *)self.arr[indexPath.row];
    cell.LeaveTypeLabel.text = array[9];
    cell.LeaveTimeLabel.text = [@"请假时长：" stringByAppendingFormat:@"%@小时",array[8]];
    cell.LeaveReasonLabel.text = array[10];
    cell.LeaveStartLabel.text = [NSString getSubstring:array[4]];
    cell.LeaveEndLabel.text = [NSString getSubstring:array[6]];
    return cell;
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
