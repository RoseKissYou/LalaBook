//
//  SearchContentViewController.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "SearchContentViewController.h"
#import "SpecialCell.h"
#import "CommonCell.h"
#import "AAASearchTool.h"
#import "AAASearchParam.h"

#import "PDDataResult.h"
#import "PDDataInfoResult.h"

#import "TableViewContentResult.h"
#import "TVCDataInfoResult.h"

#import "NSDate+DateLocationChange.h"

@interface SearchContentViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *calenderView;

@property (assign,nonatomic) NSInteger count;

@property (nonatomic,strong) NSArray *firstArr;
@property (nonatomic,strong) NSArray *secondArr;
@property (nonatomic,strong) AAASearchParam *param;
@property (nonatomic,assign) BOOL isShowCircle;

@end

@implementation SearchContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self addCalendar];
    
    //加入手势
    [self addGestureRecognizer];
    
    self.param = [AAASearchParam sharedAAASearchParam];
    
    self.param.autoid = [NSDate NSDate2FormatNSString:[NSDate date]];
    
    [self requestData];
    
}

#pragma mark - addGestureRecognizer
- (void)addGestureRecognizer{
    UISwipeGestureRecognizer *sgr = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didChangeModeTouch)];
    [sgr setDirection:(UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown)];
    [self.calenderView addGestureRecognizer:sgr];
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
        NSLog(@"%d",self.isShowCircle);
        self.count = result1.count;
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        ;
    }];
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
            SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCell" forIndexPath:indexPath];
            cell.timeOne.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[5][1]).doubleValue];

            cell.timeTwo.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[5][2]).doubleValue];

            cell.timeThree.text = [NSString stringWithFormat:@"%g",((NSNumber *)secondArr[5][3]).doubleValue];

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

#pragma mark - 以下为日历处理板块

- (void)addCalendar{
    self.calendar = [JTCalendar new];
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    self.calendar.calendarAppearance.isWeekMode = YES;
    [self changeCalendarMode:0];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.calenderView.hidden = NO;
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.calenderView.hidden = YES;
}

#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self changeCalendarMode:.5];
}

#pragma mark - JTCalendarDataSource

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    
    NSLog(@"%@",date);
    NSLog(@"%@",[NSDate NSDate2FormatNSString:date]);
    self.param.autoid = [NSDate NSDate2FormatNSString:date];
    [self requestData];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    return NO;
}

#pragma mark - 改变日历模式调用

- (void)changeCalendarMode:(CGFloat)time
{
    CGFloat newHeight = 210;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 60.;
    }
    
    [UIView animateWithDuration:time
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:time/2
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:time/2
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

@end
