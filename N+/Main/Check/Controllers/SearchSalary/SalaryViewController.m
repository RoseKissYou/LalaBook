//
//  SalaryViewController.m
//  N+
//
//  Created by hy1 on 16/1/14.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "SalaryViewController.h"
#import "AAASearchAPI.h"
#import "CommonCell.h"

#import "NSDate+DateLocationChange.h"
#import "CDatePickerViewEx.h"

@interface SalaryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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



@property (nonatomic,strong) NSArray *firstArr;
@property (nonatomic,strong) NSArray *secondArr;

@end

@implementation SalaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.param = [AAASearchParam sharedAAASearchParam];
    
    self.param.tbname = @"工资查询";
    self.param.autoid = [NSDate NSDate2FormatNSStringByMonth:[NSDate date]];
    
    [self requestData];
    
    [self setUpCalendar];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
    [[AAASearchTool sharedAAASearchTool] getPresentDailyData:self.param Success:^(NSArray *result1, NSArray *result2) {
        self.firstArr = result1;
        self.secondArr = result2;
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        ;
    }];
}

////
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
    __weak SalaryViewController *sVC = self;
    self.dpView.hidden = NO;
    self.btnView.hidden = self.dpView.hidden;
    self.dpView.returnStr = ^(NSString *str){
        NSArray *strArr = [str componentsSeparatedByString:@" "];
        sVC.indexMonth = [strArr[1] integerValue] - 1;
        label.text = [NSString stringWithFormat:@"%@年%@月",strArr[0],strArr[1]];
        sVC.currentYear = [NSString stringWithFormat:@"%@年",strArr[0]];
        sVC.selectYear = strArr[0];
        sVC.selectMonth = strArr[1];
        NSString *autoidStr = [(strArr[0]) stringByAppendingString:(strArr[1])];
        NSLog(@"%@",autoidStr);
        sVC.param.autoid = autoidStr;
    };
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
