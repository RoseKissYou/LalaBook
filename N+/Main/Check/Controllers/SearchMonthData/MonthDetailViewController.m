//
//  MonthDetailViewController.m
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "MonthDetailViewController.h"

#import "Special2Cell.h"
#import "CommonCell.h"
#import "AAASearchTool.h"
#import "AAASearchParam.h"

#import "PDDataResult.h"
#import "PDDataInfoResult.h"

#import "TableViewContentResult.h"
#import "TVCDataInfoResult.h"

#import "NSDate+DateLocationChange.h"

#import "CDatePickerViewEx.h"

@interface MonthDetailViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign,nonatomic) NSInteger count;

@property (nonatomic,strong) NSArray *firstArr;
@property (nonatomic,strong) NSArray *secondArr;
@property (nonatomic,strong) AAASearchParam *param;
@property (nonatomic,assign) BOOL isShowCircle;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArr;
@property (weak, nonatomic) IBOutlet UIView *labelView;


@property (nonatomic, strong) CDatePickerViewEx *dpView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) NSString *currentYear;
@property (nonatomic, strong) NSString *currentMonth;

@property (nonatomic, strong) NSString *selectYear;
@property (nonatomic, strong) NSString *selectMonth;

@property (nonatomic ,assign) NSInteger indexMonth;

@end

@implementation MonthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.param = [AAASearchParam sharedAAASearchParam];
    
    self.param.tbname = self.modelName;
    self.param.autoid = [NSDate NSDate2FormatNSStringByMonth:[NSDate date]];
<<<<<<< HEAD
    

=======
>>>>>>> origin/HYDeFeng
    

    

    
    [self requestData];
    
    [self setUpCalendar];
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/HYDeFeng
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back2CheckVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

///请求数据
- (void)requestData{
    [[AAASearchTool sharedAAASearchTool] getPresentDailyData:self.param Success:^(NSArray *result1, NSArray *result2) {
        self.firstArr = result1;
        self.secondArr = result2;
        for (int i = 0; i<result2.count; i++) {
            if (i>0) {
                if (((NSArray *)result2[i-1]).count == ((NSArray *)result2[i]).count) {
                    if ((((NSArray *)result2[i]).count) == 0) {
                        self.isShowCircle = NO;
                    }else{
                        self.isShowCircle = YES;
                    }
                }else{
                    self.isShowCircle = YES;
                }
            }
        }
        NSLog(@"%@",result2);
        self.count = result1.count;
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
}

- (void)back2ThisMonth{
    [self.dpView selectToday];
    NSDate *date = [NSDate date];
<<<<<<< HEAD
    self.label.text = [[NSDate NSDate2FormatNSStringByYear:date] stringByAppendingString:[NSDate NSDate2StrByMonth:date]];
=======
<<<<<<< HEAD
    self.label.text = [[NSDate NSDate2FormatNSStringByYear:date] stringByAppendingString:[NSDate NSDate2StrByMonth:date]];
=======
<<<<<<< HEAD
    self.label.text = [[NSDate NSDate2FormatNSStringByYear:date] stringByAppendingString:[NSDate NSDate2StrByMonth:date]];
=======
    self.label.text = [[NSDate NSDate2StrByYear:date] stringByAppendingString:[NSDate NSDate2StrByMonth:date]];
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
    self.currentYear = [NSDate NSDate2FormatNSStringByYear:date];
    self.selectYear = [NSDate NSDate2StrByYear:date];
    _indexMonth = index;
    [self search];
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
>>>>>>> origin/HYDeFeng
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
    __weak MonthDetailViewController *mdVC = self;
    self.dpView.hidden = NO;
    self.btnView.hidden = self.dpView.hidden;
    self.dpView.returnStr = ^(NSString *str){
        NSArray *strArr = [str componentsSeparatedByString:@" "];
        mdVC.indexMonth = [strArr[1] integerValue] - 1;
        label.text = [NSString stringWithFormat:@"%@年%@月",strArr[0],strArr[1]];
        mdVC.currentYear = [NSString stringWithFormat:@"%@年",strArr[0]];
        mdVC.selectYear = strArr[0];
        mdVC.selectMonth = strArr[1];
        NSString *autoidStr = [(strArr[0]) stringByAppendingString:(strArr[1])];
        NSLog(@"%@",autoidStr);
        mdVC.param.autoid = autoidStr;
    };
}


#pragma mark - 以下为TableView相关板块
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
#warning df-测试观察
    NSLog(@"%ld",(long)self.count);
    if (!self.isShowCircle) {
        return 0;
    }else{
        if (self.count == 0) {
            return 0;
        }else{
            return self.count + 1;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else
        return ((NSArray *)self.secondArr[section * 2 - 1]).count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *secondArr = self.secondArr;
    
    if (indexPath.section == 0) {
        Special2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCell2" forIndexPath:indexPath];
        cell.labelOne.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[3][0]).doubleValue];;
        cell.lableTwo.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[3][1]).doubleValue];;
        cell.labelThree.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[3][2]).doubleValue];;
        cell.labelFour.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[3][3]).doubleValue];;
        return cell;
    }else{
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCell" forIndexPath:indexPath];
        NSArray *arr1 = secondArr[(indexPath.section - 1)*2];
        NSArray *arr2 = secondArr[indexPath.section * 2 - 1];
        cell.keyLabel.text = arr1[indexPath.row];
        cell.valueLabel.text = arr2[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"考勤记录";
    }else
        return self.firstArr[section - 1];
}


@end
