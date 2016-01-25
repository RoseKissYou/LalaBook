//
//  RewardTableViewController.m
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "RewardTableViewController.h"
#import "AAASearchAPI.h"
#import "RewardCell.h"

#import "NSString+SubstringBySpace.h"

<<<<<<< HEAD
#import "CDatePickerViewEx.h"
#import "NSDate+DateLocationChange.h"

=======
<<<<<<< HEAD
#import "CDatePickerViewEx.h"
#import "NSDate+DateLocationChange.h"

=======
<<<<<<< HEAD
#import "CDatePickerViewEx.h"
#import "NSDate+DateLocationChange.h"

=======
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
@interface RewardTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign,nonatomic) NSInteger count;

@property (strong,nonatomic) NSArray *arr;


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArr;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (nonatomic,strong) AAASearchParam *param;

@property (nonatomic, strong) CDatePickerViewEx *dpView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) NSString *currentYear;
@property (nonatomic, strong) NSString *currentMonth;

@property (nonatomic, strong) NSString *selectYear;
@property (nonatomic, strong) NSString *selectMonth;

@property (nonatomic ,assign) NSInteger indexMonth;

@end

@implementation RewardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.param = [AAASearchParam sharedAAASearchParam];
    self.param.tbname = @"奖惩查询";
    self.param.autoid = [NSDate NSDate2FormatNSStringByMonth:[NSDate date]];
    

    
    [self requestData];
<<<<<<< HEAD
    
    [self setUpCalendar];
    
=======
    
    [self setUpCalendar];
    
>>>>>>> origin/HYDeFeng
    [self setButtonSelect];
}

- (void)setButtonSelect{
    NSInteger monthIndex = [[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian] component:NSCalendarUnitMonth fromDate:[NSDate date]];
    UIButton *btn = self.btnsArr[monthIndex - 1];
    btn.selected = YES;
    for (UIButton *button in self.btnsArr) {
        if (button != btn) {
            button.selected = NO;
        }
    }
}

- (void)requestData{
    [[AAASearchTool sharedAAASearchTool] getPresentDailyDataMore:[AAASearchParam sharedAAASearchParam] Success:^(NSArray *result1, NSArray *result2) {
        self.arr = result2;
        self.count = result2.count;
        NSLog(@"%@",self.arr);
        [self.tableView reloadData];
        
    } Failure:^(NSError *error) {
        ;
    }];
}

- (void)setUpCalendar{
    
    self.currentMonth = [NSDate NSDate2StrByMonth:[NSDate date]];
    self.currentYear = [NSDate NSDate2FormatNSStringByYear:[NSDate date]];
    self.label.text = [self.currentYear stringByAppendingString:self.currentMonth];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(datePicker)];
    [self.labelView addGestureRecognizer:tap];
    self.dpView = [[CDatePickerViewEx alloc]initWithFrame:CGRectMake(0, 0, 270, 200)];
    self.dpView.center = self.view.center;
    self.dpView.hidden = YES;
    self.dpView.backgroundColor = [UIColor colorWithRed:100/255. green:100/255. blue:100/255. alpha:0.9];
    [self.dpView selectToday];
    [self.view addSubview:self.dpView];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(self.dpView.frame.origin.x, self.dpView.frame.origin.y + self.dpView.frame.size.height, 270, 35)];
    self.btnView = btnView;
    btnView.backgroundColor = [UIColor colorWithRed:100/255. green:100/255. blue:100/255. alpha:0.9];
    self.btnView.hidden = self.dpView.hidden;
    [self.view addSubview:btnView];
    
    CGFloat w = 270/2.;
    CGFloat h = 35.;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    [btn1 setTitle:@"本月" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back2ThisMonth) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn1];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(w, 0, w, h)];
    [btn2 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btnView addSubview:btn2];
<<<<<<< HEAD
}

- (void)back2ThisMonth{
    [self.dpView selectToday];
    NSDate *date = [NSDate date];
    self.label.text = [[NSDate NSDate2FormatNSStringByYear:date] stringByAppendingString:[NSDate NSDate2StrByMonth:date]];
    self.dpView.hidden = YES;
    self.btnView.hidden = YES;
    
    NSInteger index = ((NSString *)((NSArray *)[[NSDate NSDate2StrByMonth:date] componentsSeparatedByString:@"月"])[0]).integerValue - 1;
    UIButton *btn = self.btnsArr[index];
    btn.selected = YES;
    for (UIButton *button in self.btnsArr) {
        if (button != btn) {
            button.selected = NO;
        }
    }
    self.currentYear = [NSDate NSDate2FormatNSStringByYear:date];
    self.selectYear = [NSDate NSDate2StrByYear:date];
    _indexMonth = index;
    [self search];
}

=======
}

- (void)back2ThisMonth{
    [self.dpView selectToday];
    NSDate *date = [NSDate date];
    self.label.text = [[NSDate NSDate2FormatNSStringByYear:date] stringByAppendingString:[NSDate NSDate2StrByMonth:date]];
    self.dpView.hidden = YES;
    self.btnView.hidden = YES;
    
    NSInteger index = ((NSString *)((NSArray *)[[NSDate NSDate2StrByMonth:date] componentsSeparatedByString:@"月"])[0]).integerValue - 1;
    UIButton *btn = self.btnsArr[index];
    btn.selected = YES;
    for (UIButton *button in self.btnsArr) {
        if (button != btn) {
            button.selected = NO;
        }
    }
    self.currentYear = [NSDate NSDate2FormatNSStringByYear:date];
    self.selectYear = [NSDate NSDate2StrByYear:date];
    _indexMonth = index;
    [self search];
}

>>>>>>> origin/HYDeFeng
- (void)search{
    self.dpView.hidden = YES;
    self.btnView.hidden = self.dpView.hidden;
    [self clickBtn:self.btnsArr[_indexMonth]];
}

- (IBAction)clickBtn:(UIButton *)btn {
    btn.selected = YES;
    for (UIButton *button in self.btnsArr) {
        if (button != btn) {
            button.selected = NO;
        }
    }
    self.selectMonth = [NSString stringWithFormat:@"%02ld",[self.btnsArr indexOfObject:btn] + 1];
    self.label.text = [self.currentYear stringByAppendingString:btn.titleLabel.text];
    self.param.autoid = [self.selectYear stringByAppendingString:self.selectMonth];
    [self requestData];
}


- (void)datePicker{
    __weak UILabel *label = self.label;
    __weak RewardTableViewController *rTVC = self;
    self.dpView.hidden = NO;
    self.btnView.hidden = self.dpView.hidden;
    self.dpView.returnStr = ^(NSString *str){
        NSArray *strArr = [str componentsSeparatedByString:@" "];
        rTVC.indexMonth = [strArr[1] integerValue] - 1;
        label.text = [NSString stringWithFormat:@"%@年%@月",strArr[0],strArr[1]];
        rTVC.currentYear = [NSString stringWithFormat:@"%@年",strArr[0]];
        rTVC.selectYear = strArr[0];
        rTVC.selectMonth = strArr[1];
        NSString *autoidStr = [(strArr[0]) stringByAppendingString:(strArr[1])];
        NSLog(@"%@",autoidStr);
        rTVC.param.autoid = autoidStr;
    };
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
    RewardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RCell" forIndexPath:indexPath];
     NSArray *array = (NSArray *)self.arr[indexPath.row];
    cell.rewardLabel.text = [NSString stringWithFormat:@"%ld",(long)((NSString *)array[6]).integerValue];
    cell.nameLabel.text = array[5];
    cell.reasonLabel.text = array[7];
    cell.timeLabel.text = [NSString getSubstring:array[4]];
    
    /*
     @property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
     @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
     @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
     */
    
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
